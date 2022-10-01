# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  describe 'when db schema' do
    let(:model) { described_class.column_names }

    %w[name hp attack defense sp_atk sp_def speed generation legendary].each do |field|
      it { expect(model).to include(field) }
    end
  end

  describe '.validation' do
    %i[hp attack defense sp_atk sp_def speed generation].each do |field|
      it { is_expected.to validate_numericality_of(field).only_integer.is_greater_than_or_equal_to(1) }
      it { is_expected.to validate_presence_of(field) }
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(120) }
  end

  describe '.associations' do
    it { is_expected.to have_many(:kinds).through(:pokemon_kinds) }
  end
end
