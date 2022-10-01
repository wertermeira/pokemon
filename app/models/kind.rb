# frozen_string_literal: true

class Kind < ApplicationRecord
  validates :name, presence: true, length: { maximum: 120 }
end
