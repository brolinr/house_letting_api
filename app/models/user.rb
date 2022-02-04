class User < ApplicationRecord
    validates :password_digest, presence: true, length: { minimum: 6 }, allow_nil: true
    #has_secure_password
    has_many :properties
    has_many :amounts
end
