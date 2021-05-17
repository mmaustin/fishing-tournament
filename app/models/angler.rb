class Angler < ApplicationRecord
    has_secure_password
    has_many :fish
    has_many :types, through: :fish

    validates :username, :email, :password, :catch_weight, presence: true
    validates :email, uniqueness: true
    validates :catch_weight, numericality: { equal_to: 0 }, :on => :create

    scope :weighs_more_than, ->(amount) { where("weight > ?", amount) }

end
