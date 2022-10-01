# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokemonKind, type: :model do
  describe 'when db schema' do
    let(:model) { described_class.column_names }

    %w[pokemon_id kind_id].each do |field|
      it { expect(model).to include(field) }
    end
  end

  describe '.associations' do
    it { is_expected.to belong_to(:pokemon) }
    it { is_expected.to belong_to(:kind) }
  end
end
