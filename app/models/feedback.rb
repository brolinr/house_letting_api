# frozen_string_literal: true

class Feedback < ApplicationRecord
  belongs_to :customer

  validates :description, presence: true
end
