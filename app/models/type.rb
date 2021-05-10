class Type < ApplicationRecord
    has_many :fish
    has_many :anglers, through: :fish
end
