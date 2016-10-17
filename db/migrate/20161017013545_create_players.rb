class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.references :game
      t.string :name

      t.timestamps null: false
    end
  end
end
