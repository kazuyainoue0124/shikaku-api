class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private

  def sign_up_params
    params.permit(:user_name, :email, :password, :password_confirmation)
  end
end
