class Angler < ApplicationRecord
    has_secure_password
    has_many :fish
    has_many :types, through: :fish
end
