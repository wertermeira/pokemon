# frozen_string_literal: true

class AuthenticationValidation
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :email, :password

  validates :email, :password, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Invalid email' }
end
