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
  end
end
