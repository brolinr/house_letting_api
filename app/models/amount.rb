# frozen_string_literal: true

class Amount < ApplicationRecord
  belongs_to :admin

  validates :price, presence: true, numericality: true
end
