class RemoveNameFromAnglers < ActiveRecord::Migration[6.1]
  def change
    remove_column :anglers, :name, :string
  end
end
