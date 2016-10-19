class AddSmartToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :smart, :boolean, default: false
  end
end
