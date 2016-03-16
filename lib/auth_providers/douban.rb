class DoubanAuthenticator < ::Auth::Authenticator

  def name
    'douban'
  end

  def after_authenticate(auth_token)
    result = Auth::Result.new

    data = auth_token[:info]
    raw_info = auth_token[:extra][:raw_info]
    name = data[:name]
    username = data[:nickname]
    douban_uid = auth_token[:uid]

    current_info = ::PluginStore.get('douban', "douban_uid_#{douban_uid}")

    result.user =
      if current_info
        User.where(id: current_info[:user_id]).first
      end

    result.name = name
    result.username = username
    result.extra_data = { douban_uid: douban_uid, raw_info: raw_info }

    result
  end

  def after_create_account(user, auth)
    douban_uid = auth[:extra_data][:uid]
    ::PluginStore.set('douban', "douban_uid_#{douban_uid}", {user_id: user.id})
  end

  def register_middleware(omniauth)
    omniauth.provider :douban, :setup => lambda { |env|
      strategy = env['omniauth.strategy']
      strategy.options[:client_id] = SiteSetting.zh_l10n_douban_client_id
      strategy.options[:client_secret] = SiteSetting.zh_l10n_douban_client_secret
    }
  end
end
