module LoginSupport
  module Request
    def login(user)
      post '/login', params: { email: user.email, password: user.password }
    end

    def logout
      session.delete(:user_id)
      @current_user = nil
    end

    def logged_in?
      !current_user.nil?
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
end

RSpec.configure do |config|
  config.include LoginSupport::Request, type: :request
end
