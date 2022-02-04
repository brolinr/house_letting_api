class Subscription < ApplicationRecord
  belongs_to :customer
  #before_save :check_payment_success
end
