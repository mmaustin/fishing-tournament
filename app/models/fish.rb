class Fish < ApplicationRecord
    belongs_to :angler 
    belongs_to :type

    def types=(type_attribute)
          type = Type.find_or_create_by(name: type_attribute.values[0])
          self.type_id = type.id
          self.save
    end

end
