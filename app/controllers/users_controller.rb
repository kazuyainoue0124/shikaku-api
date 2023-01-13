class UsersController < ApplicationController
  before_action :logged_in?, only: %i[update]

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      render json: { status: :created, user: @user }
    else
      render json: { status: 500, message: @user.errors.full_messages.first }
    end
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      render json: { status: :success, user: @user }
    else
      render json: { status: 'error', message: @user.errors.full_messages.first }
    end
  end

  private

  def user_params
    params.permit(:user_name, :email, :password, :password_confirmation)
  end
end
