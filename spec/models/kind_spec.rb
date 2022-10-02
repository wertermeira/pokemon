# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Kind, type: :model do
  describe 'when db schema' do
    let(:model) { described_class.column_names }

    it { expect(model).to include('name') }
  end

  describe '.validation' do
    subject { build(:kind) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(120) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe '.associations' do
    it { is_expected.to have_many(:pokemon_kinds).dependent(:destroy) }
    it { is_expected.to have_many(:pokemons).through(:pokemon_kinds) }
    it { is_expected.to belong_to(:user) }
  end
end
