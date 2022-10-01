# frozen_string_literal: true

FactoryBot.define do
  factory :pokemon_kind do
    pokemon { create(:pokemon) }
    kind { create(:kind) }
  end
end
