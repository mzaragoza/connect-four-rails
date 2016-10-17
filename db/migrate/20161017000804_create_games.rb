class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :rows,     default: 6
      t.integer :columns,  default: 7
      t.integer :number_of_players,  default: 2
      t.string  :winner

      t.timestamps null: false
    end
  end
end
