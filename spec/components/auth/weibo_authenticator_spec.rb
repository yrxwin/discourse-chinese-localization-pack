require 'rails_helper'
load File.expand_path('../../../helpers.rb', __FILE__)

RSpec.configure do |c|
  c.include PluginSpecHelpers
end

describe WeiboAuthenticator do
  let(:hash) { load_auth_hash('weibo') }
  let(:key) { "weibo_uid_#{hash[:uid]}" }

  context '.after_authenticate' do
    it 'can authenticate and create a user record for already existing users' do
      authenticator = described_class.new
      user = Fabricate(:user)

      PluginStore.set('weibo', key, {user_id: user.id})
      result = authenticator.after_authenticate(hash)
      PluginStore.remove('weibo', key)

      expect(result.user.id).to eq(user.id)
    end

    it 'can create a proper result for non existing users' do
      authenticator = described_class.new
      result = authenticator.after_authenticate(hash)

      expect(result.user).to eq(nil)
      expect(result.extra_data[:weibo_uid]).to eq('1234567890')
    end
  end

  context '.after_create_account' do
    it 'save weibo uid in plugin store' do
      authenticator = described_class.new
      user = Fabricate(:user)

      PluginStore.remove('weibo', key)
      expect(PluginStore.get('weibo', key)).to be_nil
      authenticator.after_create_account(user, { extra_data: { weibo_uid: hash[:uid] }})

      expect(PluginStore.get('weibo', key)).to eq({"user_id" => user.id})
    end
  end
end
