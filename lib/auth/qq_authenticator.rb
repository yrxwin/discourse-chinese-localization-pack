class QQAuthenticator < ::Auth::Authenticator

  def name
    'qq_connect'
  end

  def after_authenticate(auth_token)
    result = Auth::Result.new

    data = auth_token[:info]
    raw_info = auth_token[:extra][:raw_info]
    name = data['nickname']
    username = data['name']
    qq_uid = auth_token[:uid]

    current_info = ::PluginStore.get('qq', "qq_uid_#{qq_uid}")

    result.user =
      if current_info
        User.where(id: current_info[:user_id]).first
      end

    result.name = name
    result.username = username
    result.extra_data = { qq_uid: qq_uid }

    result
  end

  def after_create_account(user, auth)
    qq_uid = auth[:extra_data][:qq_uid]
    ::PluginStore.set('qq', "qq_uid_#{qq_uid}", {user_id: user.id})
  end

  def register_middleware(omniauth)
    omniauth.provider :qq_connect, :setup => lambda { |env|
      strategy = env['omniauth.strategy']
      strategy.options[:client_id] = SiteSetting.zh_l10n_qq_client_id
      strategy.options[:client_secret] = SiteSetting.zh_l10n_qq_client_secret
    }
  end
end

