# frozen_string_literal: true

class Amount < ApplicationRecord
  belongs_to :admin, foreign_key: 'user_id', class_name: 'Admin'

  validates :price, presence: true, numericality: true
end
