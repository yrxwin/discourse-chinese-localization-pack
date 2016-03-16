# name: 中文本地化服务集合
# about: 为 Discourse 增加了各种本地化的功能。
# version: 0.5
# authors: Erick Guan
# url: https://github.com/fantasticfears/discourse-chinese-localization-pack

enabled_site_setting :zh_l10n_enabled

register_asset 'stylesheets/auth_providers.scss'

# load oauth providers
load File.expand_path('../lib/auth_providers/providers.rb', __FILE__)
require 'active_support/inflector'

# Name, frame_width, frame_height, background_color
PROVIDERS = [
  ['Weibo', 920, 800, 'rgb(230, 22, 45)'],
  ['Douban', 380, 460, 'rgb(42, 172, 94)'],
  ['QQ', 760, 500, '#51b7ec'],
  ['Renren', 950, 500, 'rgb(0, 94, 172)']
].freeze
PLUGIN_PREFIX = 'zh_l10n_'.freeze

PROVIDERS.each do |provider|
  auth_provider authenticator: "#{provider[0]}Authenticator".constantize.new,
                frame_width: provider[1],
                frame_height: provider[2],
                background_color: provider[3]
end

after_initialize do
  return unless SiteSetting.zh_l10n_enabled

  PROVIDERS.each do |provider|
    provider_name = provider[0].downcase
    enable_setting = "#{PLUGIN_PREFIX}enable_#{provider_name}_logins"
    next unless SiteSetting.public_send(enable_setting)

    check = "#{provider_name}_config_check".to_sym
    AdminDashboardData.define_singleton_method(check) do
      if SiteSetting.public_send(enable_setting) && (
          SiteSetting.public_send("#{PLUGIN_PREFIX}#{provider_name}_client_id").blank? ||
          SiteSetting.public_send("#{PLUGIN_PREFIX}#{provider_name}_client_secret").blank?)
        I18n.t("dashboard.#{PLUGIN_PREFIX}#{provider_name}_config_warning")
      end
    end
    AdminDashboardData.add_problem_check check
  end
end
