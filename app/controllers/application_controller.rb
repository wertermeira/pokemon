# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authorize_request
  rescue_from ActiveRecord::RecordNotFound do
    render json: { status: 404, message: 'Not found' }, status: :not_found
  end

  private

  def authorize_request
    Current.user = User.find(authenticate_token[:user_id])
  rescue StandardError => e
    render json: { errors: e.message }, status: :unauthorized
  end


  def authenticate_token
    authenticate_with_http_token do |token|
      JwtToken.decode(token)
    end
  end
end
