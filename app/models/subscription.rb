# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :customer
  enum :payment_status, %i[pending paid error cancelled refunded]

  validates :poll_url, :month, :ecocash_number, presence: true
  validates :fee, presence: true, numericality: true
  validates :payment_status, presence: true
end
