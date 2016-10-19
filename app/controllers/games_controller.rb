class GamesController < ApplicationController
  expose :games, ->{ Games.all }
  expose :game

  def create
    game.game_type = params[:game_type]
    if params[:game_type] == 'human_vs_pc_hard'
      game.smart = true
    end
    game.save
    redirect_to game_path(game)
  end
end
