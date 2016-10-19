class Game < ActiveRecord::Base

  has_many :players
  has_many :moves

  after_create :create_players

  def current_player
    if moves.count % 2 == 0
      player = players.first
    else
      player = players.last
    end
    player
  end

  def choose_column
    column = Move.get_random_columns(self)
  end

  private
  def create_players
    players.create(name: 'Red')
    players.create(name: 'Black')
  end

end
