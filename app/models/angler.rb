class Angler < ApplicationRecord
    has_secure_password
    has_many :fish
    has_many :types, through: :fish
    
    validates :username, :email, :catch_weight, presence: true
    validates :username, :email, uniqueness: true
    validates :catch_weight, numericality: { equal_to: 0 }

end
