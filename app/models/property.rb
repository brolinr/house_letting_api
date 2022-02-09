class Property < ApplicationRecord
    has_one_attached :image

    validates_presence_of :city, :address, :description, :contact
    belongs_to :user
end
