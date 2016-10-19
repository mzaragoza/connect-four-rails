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

  def self.get_random_columns(game)
    columns = 0.upto(game.columns - 1).to_a - game.moves.where(row: 1).map(&:column).flatten
    columns.sample
  end

  private
  def winning_move?
    winner = check_if_win_by_row
    unless winner
      winner = check_if_win_by_column
    end
    unless winner
      winner = check_if_win_by_diagonal_left
    end
    unless winner
      winner = check_if_win_by_diagonal_right
    end
    if winner
      game = self.game
      game.winner = player.name
      game.save
    end
  end

  def players_moves
    game.moves.where(player_id: player_id).order(:row, :column)
  end

  def check_if_win_by_row
    moves = players_moves
    moves.each do |move|
      winner = false
      counter = 0
      1.upto(3) do |counters|
        if moves.where(row: move.row + counters, column: move.column).count > 0
          counter = counter + 1
          if counter == 3
            return winner = true
          end
        end
      end
    end
    return winner = false
  end

  def check_if_win_by_column
    moves = players_moves
    moves.each do |move|
      winner = false
      counter = 0
      1.upto(3) do |counters|
        if moves.where(row: move.row, column: move.column + counters).count > 0
          counter = counter + 1
          if counter == 3
            return winner = true
          end
        end
      end
    end
    return winner = false
  end

  def check_if_win_by_diagonal_left
    moves = players_moves
    moves.each do |move|
      counter = 0
      winner = false
      1.upto(3) do |counters|
        if moves.where(row: move.row + counters, column: move.column - counters).count > 0
          counter = counter + 1
          if counter == 3
            return winner = true
          end
        end
      end
    end
    return winner = false
  end

  def check_if_win_by_diagonal_right
    moves = players_moves
    moves.each do |move|
      counter = 0
      winner = false
      1.upto(3) do |counters|
        if moves.where(row: move.row + counters, column: move.column + counters).count > 0
          counter = counter + 1
          if counter == 3
            return winner = true
          end
        end
      end
    end
    return winner = false
  end

end
