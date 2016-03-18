require 'rails_helper'
load File.expand_path('../../../helpers.rb', __FILE__)

RSpec.configure do |c|
  c.include PluginSpecHelpers
end

describe WeiboAuthenticator do
  let(:hash) { load_auth_hash('weibo') }
  let(:key) { "weibo_uid_#{hash[:uid]}" }

  context '.after_authenticate' do
    context 'with existing weibo login record' do
      before { PluginStore.set('weibo', key, {user_id: user.id}) }
      after { PluginStore.remove('weibo', key) }
      let(:user) { Fabricate(:user) }

      it 'can authenticate existing user given weibo uid' do
        authenticator = described_class.new

        result = authenticator.after_authenticate(hash)

        expect(result.user.id).to eq(user.id)
      end

      it 'can store additional information' do
        authenticator = described_class.new

        authenticator.after_authenticate(hash)

        expect(PluginStore.get('weibo', key)[:raw_info]).to be_a(Hash)
        expect(PluginStore.get('weibo', key)[:raw_info][:city]).to eq('广州')
      end
    end

    it 'can create a proper result for non existing users' do
      authenticator = described_class.new
      result = authenticator.after_authenticate(hash)

      expect(result.user).to eq(nil)
      expect(result.extra_data[:weibo_uid]).to eq('1234567890')
    end
  end

  context '.after_create_account' do
    let(:user) { Fabricate(:user) }
    context 'with existing plugin record' do
      before { PluginStore.set('weibo', key, {user_id: user.id, raw_info: 1}) }
      after { PluginStore.remove('weibo', key) }

      it 'merge weibo uid in plugin store' do
        authenticator = described_class.new

        authenticator.after_create_account(user, { extra_data: { weibo_uid: hash[:uid] }})

        expect(PluginStore.get('weibo', key)).to eq({"user_id" => user.id, "raw_info" => 1})
      end
    end

    context 'without existing plugin record' do
      before { PluginStore.remove('weibo', key) }
      after { PluginStore.remove('weibo', key) }

      it 'creates record in plugin store' do
        authenticator = described_class.new

        authenticator.after_create_account(user, { extra_data: { weibo_uid: hash[:uid] }})

        expect(PluginStore.get('weibo', key)).to eq({"user_id" => user.id})
      end
    end
  end
end
