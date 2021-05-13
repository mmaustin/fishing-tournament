class RemoveWeightFromFish < ActiveRecord::Migration[6.1]
  def change
    remove_column :fish, :weight, :integer
  end
end
