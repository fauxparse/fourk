class MovesController < ApplicationController
  def create
    PlayTurn.new(game, player, params.require(:move))
      .on(:success) { |turn| render json: turn }
      .call
  end

  private

  def game
    @game ||= Game.includes(:moves).find(params[:game_id])
  end

  def player
    game.players.find_by(user_id: current_user.id)
  end
end
