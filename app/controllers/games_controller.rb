class GamesController < ApplicationController
  def show
    @game = Game.new(board_shape: :rhombus, board_size: 5)
    @game_presenter = GamePresenter.new(@game)
  end

  def create
    CreateGame.new(current_user)
      .on(:success) { |game| redirect_to game }
      .on(:failure) { |game| render :new }
      .call
  end

  def join
    JoinGame.new(current_user, game)
      .on(:success) { redirect_to game }
      .on(:already_playing, :full) { redirect_to games_path }
      .on(:failure) { |_| redirect_to games_path }
      .call
  end

  private

  def game
    @game ||= Game.find(params[:id])
  end
end
