class Game < ActiveRecord::Base

  has_many :players
  has_many :moves

  after_create :create_platers

  private
  def create_platers
    players.create(name: 'red')
    players.create(name: 'blue')
  end

end
