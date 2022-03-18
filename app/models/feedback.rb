class Feedback < ApplicationRecord
    belongs_to :customer
    validates_presence_of :description
end
