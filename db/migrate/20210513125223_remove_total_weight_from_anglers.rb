class RemoveTotalWeightFromAnglers < ActiveRecord::Migration[6.1]
  def change
    remove_column :anglers, :total_weight, :integer
  end
end
