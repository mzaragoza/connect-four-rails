class Move < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  validates :game_id, presence: true
  validates :player_id, presence: true
  validates :row, presence: true, :numericality => { :greater_than_or_equal_to => 1 }
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
    #get all moves by player
    winner = check_if_win_by_row
    unless winner
      winner = check_if_win_by_column
    end
    if winner
      game = self.game
      game.winner = player.name
      game.save
    end
  end

  private
  def players_moves
    game.moves.where(player_id: player_id).order(:row, :column)
  end

  def check_if_win_by_row
    moves = players_moves
    1.upto(game.rows) do |row|
      winner = false
      counter = 0
      game.columns.times do |column|
        if moves.where(row: row, column: column).count > 0
          counter = counter + 1
          if counter >= 4
            return winner = true
          end
        else
          counter = 0
        end
      end
    end
    return winner = false
  end

  def check_if_win_by_column
    moves = players_moves
    game.columns.times do |column|
      winner = false
      counter = 0
      1.upto(game.rows) do |row|
        if moves.where(row: row, column: column).count > 0
          counter = counter + 1
          if counter >= 4
            return winner = true
          end
        else
          counter = 0
        end
      end
    end
    return winner = false
  end

end
