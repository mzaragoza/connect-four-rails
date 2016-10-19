class AddGameTypeToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :game_type, :string, default: 'pc_vs_pc'
  end
end
