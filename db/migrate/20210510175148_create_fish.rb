class CreateFish < ActiveRecord::Migration[6.1]
  def change
    create_table :fish do |t|
      t.integer :weight
      t.integer :angler_id
      t.integer :type_id

      t.timestamps
    end
  end
end
