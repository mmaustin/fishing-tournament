class Fish < ApplicationRecord
    attr_accessor :previous_weight
    belongs_to :angler 
    belongs_to :type
    validates :weight, :type_id, :angler_id, presence: true
    validates :weight, numericality: true
    validates :previous_weight, presence: true, on: :update

    scope :weighs_more_than, ->(amount) { where("weight > ?", amount) }
    accepts_nested_attributes_for :type

=begin
    def types=(type_attribute)
        #binding.pry
          type = Type.find_or_create_by(name: type_attribute.values[0])
          self.type_id = type.id
          #self.save
    end
=end

    def weight_total
        self.angler.catch_weight += self.weight
        self.angler.save(validate: false)
    end

    def update_weight_total
        pw = self.previous_weight.to_i
        if  pw > self.weight
            a = pw - self.weight
            self.angler.catch_weight -= a
            self.angler.save(validate: false)
        elsif pw < self.weight
            c = self.weight - pw
            self.angler.catch_weight += c 
            self.angler.save(validate: false)
        elsif pw == self.weight
            self.angler.catch_weight += 0
            self.angler.save(validate: false)
        end

    end

end
