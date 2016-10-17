class Move < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  validates :game_id, presence: true
  validates :player_id, presence: true
  validates :row, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :column, presence: true

  after_create :winning_move?

  def self.get_row(options = {})
    game = Game.find(options[:game_id])
    moves = game.moves.where(column: options[:column])
    if moves.count > 0
      row = moves.order(:row).first.row - 1
    else
      row = game.rows
    end
    row
  end

  def winning_move?
    if true ==  false
      game = self.game
      game.winner = player.id
      game.save
    end
  end
end
