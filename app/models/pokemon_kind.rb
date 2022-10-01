# frozen_string_literal: true

class PokemonKind < ApplicationRecord
  belongs_to :pokemon
  belongs_to :kind
end
