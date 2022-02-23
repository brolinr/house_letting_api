class Customer < ApplicationRecord
    has_many :subscriptions
    validates_uniqueness_of :phone
end