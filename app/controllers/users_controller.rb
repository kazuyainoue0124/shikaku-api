class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      render json: { status: :created, user: @user }
    else
      render json: { status: 500, message: @user.errors.full_messages.first }
    end
  end

  private

  def user_params
    params.permit(:user_name, :email, :password, :password_confirmation)
  end
end
