class RenrenAuthenticator < ::Auth::Authenticator

  def name
    'renren'
  end

  def after_authenticate(auth_token)
    result = Auth::Result.new

    data = auth_token[:info]
    raw_info = auth_token[:extra][:raw_info]
    name = data[:name]
    username = data[:nickname]
    renren_uid = auth_token[:uid]

    current_info = ::PluginStore.get('renren', "renren_uid_#{renren_uid}")

    result.user =
      if current_info
        User.where(id: current_info[:user_id]).first
      end

    result.name = name
    result.username = username
    result.extra_data = { renren_uid: renren_uid }

    result
  end

  def after_create_account(user, auth)
    renren_uid = auth[:extra_data][:renren_uid]
    ::PluginStore.set('renren', "renren_uid_#{renren_uid}", {user_id: user.id})
  end

  def register_middleware(omniauth)
    omniauth.provider :renren, :setup => lambda { |env|
      strategy = env['omniauth.strategy']
      strategy.options[:client_id] = SiteSetting.zh_l10n_renren_client_id
      strategy.options[:client_secret] = SiteSetting.zh_l10n_renren_client_secret
    }
  end
end
