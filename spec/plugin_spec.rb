require 'rails_helper'

load File.expand_path('../helpers.rb', __FILE__)

describe 'discourse-chinese-localization-pack' do
  it 'load all authenticators' do
    ['Weibo', 'Douban', 'QQ', 'Renren', 'Wechat'].each do |provider_name|
      expect(Discourse.auth_providers.any? { |a| a.authenticator.class.name.demodulize == "#{provider_name}Authenticator" }).to be_truthy
    end
  end
end
