class GamesController < ApplicationController
  def show
    @game = Game.new(board_shape: :hexagon, board_size: 5)
    @game_presenter = GamePresenter.new(@game)
  end
end
