class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!, only: %i[show]

  def show
    # User.find(params[:id])では@userが存在しない場合にnilではなくエラーを発生させてしまう
    @user = User.find_by(id: params[:id])
    if @user
      render json: { status: :success, user: @user }
    else
      render json: { status: 'error', message: 'ユーザーが見つかりませんでした' }
    end
  end

  private

  def user_params
    params.permit(:id, :user_name, :email, :password, :password_confirmation, :profile)
  end
end
