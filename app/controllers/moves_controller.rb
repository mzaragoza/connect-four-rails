class MovesController < ApplicationController
  skip_before_action :verify_authenticity_token,  :only => [:create]
  expose :game, ->{ Game.find(parms[:game_id]) }
  expose :moves, ->{ game.moves }
  expose :move

  def create
    row = Move.get_row({game_id: params[:game_id], column: params[:column]})
    Move.create(
      game_id: params[:game_id],
      player_id: params[:player_id],
      column: params[:column],
      row: row
    )
    redirect_to :back
  end

  private

  def move_params
    params.require(:move).permit(
      :game_id,
      :player_id,
      :column,
    )
  end
end
