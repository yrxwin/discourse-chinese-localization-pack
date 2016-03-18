require 'rails_helper'
load File.expand_path('../../../helpers.rb', __FILE__)

RSpec.configure do |c|
  c.include PluginSpecHelpers
end

describe QQAuthenticator do
  let(:hash) { load_auth_hash('qq') }
  let(:key) { "qq_uid_#{hash[:uid]}" }

  context '.after_authenticate' do
    context 'with existing qq login record' do
      before { PluginStore.set('qq', key, {user_id: user.id}) }
      after { PluginStore.remove('qq', key) }
      let(:user) { Fabricate(:user) }

      it 'can authenticate existing user given qq uid' do
        authenticator = described_class.new

        result = authenticator.after_authenticate(hash)

        expect(result.user.id).to eq(user.id)
      end

      it 'can store additional information' do
        authenticator = described_class.new

        authenticator.after_authenticate(hash)

        expect(PluginStore.get('qq', key)[:raw_info]).to be_a(Hash)
        expect(PluginStore.get('qq', key)[:raw_info][:dummy]).to eq('test')
      end
    end

    it 'can create a proper result for non existing users' do
      authenticator = described_class.new
      result = authenticator.after_authenticate(hash)

      expect(result.user).to eq(nil)
      expect(result.extra_data[:qq_uid]).to eq('1D341A5F76CD6CE74C3A664F8565D4B42D')
    end
  end

  context '.after_create_account' do
    let(:user) { Fabricate(:user) }
    context 'with existing plugin record' do
      before { PluginStore.set('qq', key, {user_id: user.id, raw_info: 1}) }
      after { PluginStore.remove('qq', key) }

      it 'merge qq uid in plugin store' do
        authenticator = described_class.new

        authenticator.after_create_account(user, { extra_data: { qq_uid: hash[:uid] }})

        expect(PluginStore.get('qq', key)).to eq({"user_id" => user.id, "raw_info" => 1})
      end
    end

    context 'without existing plugin record' do
      before { PluginStore.remove('qq', key) }
      after { PluginStore.remove('qq', key) }

      it 'creates record in plugin store' do
        authenticator = described_class.new

        authenticator.after_create_account(user, { extra_data: { qq_uid: hash[:uid] }})

        expect(PluginStore.get('qq', key)).to eq({"user_id" => user.id})
      end
    end
  end
end
