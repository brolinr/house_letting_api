# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :customer, foreign_key: 'user_id'

  enum payment_status: { pending: 0, paid: 1, error: 2, cancelled: 3, refunded: 4 }

  validates :poll_url, presence: true
  validates :month, presence: true
  validates :ecocash_number, presence: true
  validates :fee, presence: true, numericality: true
  validates :payment_status, presence: true
end
