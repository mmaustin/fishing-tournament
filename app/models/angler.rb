class Angler < ApplicationRecord
    has_secure_password
    has_many :fish
    has_many :types, through: :fish
    validates :username, presence: true
    validates :email, presence: true
    validates :catch_weight, numericality: { equal_to: 0 }

end
