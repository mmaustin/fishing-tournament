class CatchWeightValidator < ActiveModel::Validator
    def validate(record)
        unless record.catch_weight == 0.0
          record.errors[:catch_weight] << "The initial catch weight must be 0.0."
        end
    end
end