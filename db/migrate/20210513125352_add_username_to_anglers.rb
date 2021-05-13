class AddUsernameToAnglers < ActiveRecord::Migration[6.1]
  def change
    add_column :anglers, :username, :string
  end
end
