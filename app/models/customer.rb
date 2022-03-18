class Customer < ApplicationRecord
    has_many :subscriptions
    has_many :feedbacks
    validates_uniqueness_of :phone
end