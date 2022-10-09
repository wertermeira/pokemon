# frozen_string_literal: true

class AuthenticationsController < ApplicationController
  skip_before_action :authorize_request

  def create
    validation = AuthenticationValidation.new(login_params)
    return try_auth if validation.valid?

    render json: { error: validation.errors }, status: :unprocessable_entity
  end

  private

  def try_auth
    @user = User.find_by(email: login_params[:email])
    if @user&.authenticate(login_params[:password])
      render_json
    else
      render json: { error: 'email or password invalid' }, status: :unprocessable_entity
    end
  end

  def render_json
    token = JwtToken.encode(user_id: @user.id)
    time = Time.zone.now + 24.hours.to_i
    render json: { token: token, exp: time.strftime('%m-%d-%Y %H:%M'), email: @user.email }, status: :created
  end

  def login_params
    params.require(:authentication).permit(:email, :password)
  end
end
