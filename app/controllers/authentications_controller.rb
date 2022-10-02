

class AuthenticationsController < ApplicationController
  skip_before_action :authorize_request

  def create
    @user = User.find_by_email(login_params[:email])
    if @user&.authenticate(login_params[:password])
      token = JwtToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                    email: @user.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.require(:login).permit(:email, :password)
  end
end