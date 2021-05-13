class AddCatchWeightToAnglers < ActiveRecord::Migration[6.1]
  def change
    add_column :anglers, :catch_weight, :float
  end
end
