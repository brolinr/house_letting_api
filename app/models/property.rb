class Property < ApplicationRecord
    has_one_attached :image

    validate :image_present?

    private

    def image_present?
        errors.add(:image, :blank) unless image.attached?
    end
end
