# frozen_string_literal: true

FactoryBot.define do
  factory :kind do
    user { create(:user) }
    name { %w[Grass Pison Fire Bug Water].sample }

    trait :unique_items do
      sequence(:name) { |n| "#{Faker::Name.name} #{n + 1}" }
    end
  end
end
