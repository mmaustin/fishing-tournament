class Fish < ApplicationRecord
    belongs_to :angler 
    belongs_to :type
    validates :weight, :type_id, :angler_id, presence: true
    validates :weight, numericality: true

    scope :weighs_more_than, ->(amount) { where("weight > ?", amount) }

    def types=(type_attribute)
        #binding.pry
          type = Type.find_or_create_by(name: type_attribute.values[0])
          self.type_id = type.id
          #self.save
    end

    def weight_total
        self.angler.catch_weight += self.weight
        self.angler.save(validate: false)
    end

end
