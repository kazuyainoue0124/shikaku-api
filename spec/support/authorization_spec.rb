module AuthorizationHelper
  def sign_in(user)
    post '/api/v1/auth/sign_in', params: { email: user.email, password: user.password }
    # レスポンスのHeadersからトークン認証に必要な要素を抜き出して返す処理
    response.headers.slice('client', 'uid', 'access-token')
  end
end

RSpec.configure do |config|
  config.include AuthorizationHelper, type: :request
end
