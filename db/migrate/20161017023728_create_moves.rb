class CreateMoves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.references :game
      t.references :player
      t.integer :row
      t.integer :column

      t.timestamps null: false
    end
  end
end

