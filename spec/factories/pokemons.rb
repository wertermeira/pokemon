# frozen_string_literal: true

FactoryBot.define do
  factory :pokemon do
    name { Faker::Games::Pokemon.name }
    hp { rand(1..100) }
    attack { rand(1..100) }
    defense { rand(1..100) }
    sp_atk { rand(1..100) }
    sp_def { rand(1..100) }
    speed { rand(1..100) }
    generation { rand(1..3) }
    legendary { [false, true].sample }

    trait :unique_items do
      sequence(:name) { |n| "#{Faker::Name.name} #{n + 1}" }
    end

    trait :with_kinds do
      after :create do |pokemon|
        create(:pokemon_kind, pokemon: pokemon)
      end
    end
  end
  factory :with_kinds, traits: %i[with_kinds]
end
