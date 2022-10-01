# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Kind, type: :model do
  describe 'when db schema' do
    let(:model) { described_class.column_names }

    it { expect(model).to include('name') }
  end

  describe '.validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(120) }
  end

  describe '.associations' do
    it { is_expected.to have_many(:pokemons).through(:pokemon_kinds) }
  end
end
