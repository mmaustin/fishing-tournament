class AddAttributesToAnglers < ActiveRecord::Migration[6.1]
  def change
    add_column :anglers, :uid, :string
    add_column :anglers, :provider, :string
  end
end
