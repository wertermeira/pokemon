# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JwtToken do
  let(:time) { 24.hours.from_now }
  let(:user_id) { rand(1..20) }
  let(:payload) { { user_id: user_id, exp: time.to_i } }
  let(:secret_key_base) { Faker::Internet.password }
  let(:token) { Faker::Internet.password }

  before do
    allow(Rails.application.secrets).to receive(:secret_key_base).and_return(secret_key_base)
  end

  describe '.encode' do
    before do
      allow(JWT).to receive(:encode).with(payload, secret_key_base).and_return(token)
    end

    it do
      expect(described_class.encode({ user_id: user_id }, time)).to eq(token)
    end
  end

  describe '.decode' do
    let(:token) { described_class.encode({ user_id: user_id }, time) }

    it do
      expect(described_class.decode(token)).to eq(HashWithIndifferentAccess.new(payload))
    end
  end
end
