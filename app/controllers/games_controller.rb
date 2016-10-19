class GamesController < ApplicationController
  expose :games, ->{ Games.all }
  expose :game

  def create
    game.game_type = params[:game_type]
    game.save
    redirect_to game_path(game)
  end
end
