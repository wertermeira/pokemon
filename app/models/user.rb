# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :pokemons, dependent: :destroy
  has_many :kinds, dependent: :destroy

  validates :password, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :password,
            length: { minimum: 6, maximum: 20 },
            if: -> { new_record? || !password.nil? }

  before_save do
    self.email = email.downcase
  end
end
