class CreateAnglers < ActiveRecord::Migration[6.1]
  def change
    create_table :anglers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :hometown
      t.integer :age
      t.integer :total_weight

      t.timestamps
    end
  end
end
