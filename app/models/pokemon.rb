# frozen_string_literal: true

class Pokemon < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  has_many :pokemon_kinds, dependent: :destroy
  has_many :kinds, through: :pokemon_kinds

  validates :name, presence: true, length: { maximum: 120 }, uniqueness: { case_sensitive: false }
  validates :hp, :attack, :defense, :sp_atk, :sp_def,
            :speed, :generation, presence: true,
                                 numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def total
    [hp, attack, defense, sp_atk, sp_def, speed].sum
  end
end
