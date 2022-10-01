# frozen_string_literal: true

class KindSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at
end
