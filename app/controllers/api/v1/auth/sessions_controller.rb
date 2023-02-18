class Api::V1::Auth::SessionsController < ApplicationController
  def index
    if api_v1_user_signed_in?
      render json: { loginStatus: true, user: current_api_v1_user }
    else
      render json: { loginStatus: false, message: 'ユーザーが存在しません' }
    end
  end
end
