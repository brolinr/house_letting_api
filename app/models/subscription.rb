class Subscription < ApplicationRecord
  belongs_to :customer
  validates_presence_of :poll_url, :month, :ecocash_number
end
