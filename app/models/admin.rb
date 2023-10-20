class Admin < User
  has_many :properties
  has_many :amounts

  validates :phone, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end