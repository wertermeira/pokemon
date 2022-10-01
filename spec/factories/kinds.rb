# frozen_string_literal: true

FactoryBot.define do
  factory :kind do
    name { %w[Grass Pison Fire Bug Water].sample }
  end
end
