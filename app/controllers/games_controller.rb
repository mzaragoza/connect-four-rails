class GamesController < ApplicationController
  expose :games, ->{ Games.all }
  expose :game
  expose :moves, ->{ game.moves }
  expose :players, ->{ game.players }
  expose :player, ->{
    if game.moves.count % 2 == 0
      players.first
    else
      players.last
    end
  }
  expose :winner, ->{ Player.find(game.winner) }

  def create
    game.save
    redirect_to game_path(game)
  end
end
