class Fish < ApplicationRecord
    belongs_to :angler 
    belongs_to :type
end
