class User < ApplicationRecord
  has_secure_password

  validates :password, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 6, maximum: 20 },
            if: -> { new_record? || !password.nil? }
end
