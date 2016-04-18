class GamesController < ApplicationController
  def index
    @games = GamesForUser.new(current_user).games
  end

  def show
    @game_presenter = GamePresenter.new(game, current_user)
  end

  def create
    CreateGame.new(current_user)
      .on(:success) { |game| redirect_to games_path }
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

  def destroy
    game.destroy
    redirect_to games_path
  end

  private

  def game
    @game ||= Game.find(params[:id])
  end
end
