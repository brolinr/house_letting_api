class Property < ApplicationRecord
    has_one_attached :image

    validate_presence_of :name, :address, :description, :contact

end
