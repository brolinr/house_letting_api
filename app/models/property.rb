class Property < ApplicationRecord
    #has_one_attached :image
    validates_presence_of :description, :contact
    belongs_to :user
end
