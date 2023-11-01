# frozen_string_literal: true

class Property < ApplicationRecord
  belongs_to :admin, foreign_key: 'user_id'

  validates :description, presence: true
  validates :location, presence: true
  validates :owner_phone, presence: true
  validates :owner_whatsapp, presence: true
  validates :owner_email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
end
