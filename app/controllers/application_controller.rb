# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do
    render json: { status: 404, message: 'Not found' }, status: :not_found
  end
end
