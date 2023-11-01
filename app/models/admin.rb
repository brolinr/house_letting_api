# frozen_string_literal: true

class Admin < User
  has_many :properties, class_name: 'Property', foreign_key: 'user_id', dependent: :destroy
  has_many :amounts, class_name: 'Amount', foreign_key: 'user_id', dependent: :nullify

  validates :phone, presence: true, uniqueness: true
  validates :name, presence: true
end
