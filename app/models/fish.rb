class Fish < ApplicationRecord
    belongs_to :angler 
    belongs_to :type
    validates :weight, numericality: true

    def types=(type_attribute)
        #binding.pry
          type = Type.find_or_create_by(name: type_attribute.values[0])
          self.type_id = type.id
          #self.save
    end

end
