class ApplicationController < ActionController::API
  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    return if current_user

    render json: { is_logged_in: false, message: 'ログインが必要です！' }
  end
end
