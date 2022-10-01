# frozen_string_literal: true

class Pokemon < ApplicationRecord
  validates :name, presence: true, length: { maximum: 120 }
  validates :hp, :attack, :defence, :sp_atk, :sp_def,
            :speed, :generation, presence: true,
                                 numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
