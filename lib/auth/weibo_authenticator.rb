class WeiboAuthenticator < ::Auth::Authenticator

  def name
    'weibo'
  end

  def after_authenticate(auth_token)
    result = Auth::Result.new

    data = auth_token[:info]
    email = auth_token[:extra][:email] || "#{data['nickname'].downcase}@sina.com"
    raw_info = auth_token[:extra][:raw_info]
    weibo_uid = auth_token[:uid]

    current_info = ::PluginStore.get('weibo', "weibo_uid_#{weibo_uid}")

    if current_info
      result.user = User.where(id: current_info[:user_id]).first
    else
      current_info = Hash.new
    end
    current_info.store(:raw_info, raw_info)
    ::PluginStore.set('weibo', "weibo_uid_#{weibo_uid}", current_info)

    result.name = data['name']
    result.username = data['nickname']
    result.email = email
    result.extra_data = { weibo_uid: weibo_uid }

    result
  end

  def after_create_account(user, auth)
    weibo_uid = auth[:extra_data][:weibo_uid]
    current_info = ::PluginStore.get('weibo', "weibo_uid_#{weibo_uid}") || {}
    ::PluginStore.set('weibo', "weibo_uid_#{weibo_uid}", current_info.merge(user_id: user.id))
  end

  def register_middleware(omniauth)
    omniauth.provider :weibo, :setup => lambda { |env|
      strategy = env['omniauth.strategy']
      strategy.options[:client_id] = SiteSetting.zh_l10n_weibo_client_id
      strategy.options[:client_secret] = SiteSetting.zh_l10n_weibo_client_secret
      strategy.options[:token_params] = { redirect_uri: "#{Discourse.base_url}/auth/weibo/callback" }
    }
  end
end
