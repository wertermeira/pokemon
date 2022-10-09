# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'when db schema' do
    let(:model) { described_class.column_names }

    %w[email password_digest].each do |column|
      it { expect(model).to include(column) }
    end
  end

  describe '.have_secure_password' do
    it { is_expected.to have_secure_password }
  end

  describe '.associations' do
    it { is_expected.to have_many(:pokemons).dependent(:destroy) }
    it { is_expected.to have_many(:kinds).dependent(:destroy) }
  end

  describe '.validation' do
    subject { build(:user) }

    it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(20) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
    it { is_expected.not_to allow_value('email.com').for(:email) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end
end
