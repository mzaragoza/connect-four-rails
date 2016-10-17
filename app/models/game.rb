class Game < ActiveRecord::Base

  has_many :players
  has_many :moves

  after_create :create_players

  def current_player
    if moves.count % 2 == 0
      players.first
    else
      players.last
    end
  end

  private
  def create_players
    players.create(name: 'red')
    players.create(name: 'blue')
  end

end
