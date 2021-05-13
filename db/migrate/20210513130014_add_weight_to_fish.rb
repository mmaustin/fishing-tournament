class AddWeightToFish < ActiveRecord::Migration[6.1]
  def change
    add_column :fish, :weight, :float
  end
end
