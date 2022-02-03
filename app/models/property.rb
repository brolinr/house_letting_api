class Property < ApplicationRecord
    has_one_attached :image

    validates_presence_of :name, :address, :description, :contact
    belongs_to :user
end
