# frozen_string_literal: true

class Property < ApplicationRecord
  belongs_to :admin

  validates :description, :contact, presence: true
end
