# frozen_string_literal: true

class Kind < ApplicationRecord
  has_many :pokemon_kinds, dependent: :destroy
  has_many :pokemons, through: :pokemon_kinds
  validates :name, presence: true, length: { maximum: 120 }
end
