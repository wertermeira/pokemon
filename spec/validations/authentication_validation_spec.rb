# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationValidation, type: :model do
  describe '.validation' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
    it { is_expected.not_to allow_value('email.com').for(:email) }
  end
end
