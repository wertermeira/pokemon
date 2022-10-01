# frozen_string_literal: true

class PokemonSerializer < ActiveModel::Serializer
  attributes :id, :name, :total, :hp, :attack, :defense, :sp_atk, :sp_def,
             :speed, :generation, :legendary, :created_at, :updated_at
  has_many :kinds, serializer: KindSerializer
end
