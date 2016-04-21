class GamesController < ApplicationController
  helper_method :current_player

  def index
    @games = GamesForUser.new(current_user).games
  end

  def show
    @game_presenter = GamePresenter.new(game, current_user)
  end

  def create
    CreateGame.new(current_user)
      .on(:success) do |game|
        self.current_player = game.players.first
        redirect_to games_path
      end
      .on(:failure) { |game| render :new }
      .call
  end

  def join
    JoinGame.new(current_user, game)
      .on(:success) do |player|
        self.current_player = player
        redirect_to game
      end
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
    @game ||= Game.includes(turns: :moves).find(params[:id])
  end

  def current_player
    @player ||= game.players.detect do |player|
      player.user_id == current_user.id
    end
  end

  def current_player=(player)
    @player = player
    cookies.signed[:user_id] = current_user.id
  end
end
