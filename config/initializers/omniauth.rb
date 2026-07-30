Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
end

if Rails.env.development? && ENV['OMNIAUTH_MOCK'] == 'true'
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
    provider: 'google_oauth2',
    uid: 'local-dev-user',
    info: {
      name: 'ローカル確認ユーザー'
    }
  )
end
