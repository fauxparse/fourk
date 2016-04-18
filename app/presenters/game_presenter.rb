class GamePresenter
  def initialize(game, user)
    @game = game
    @user = user
  end

  def board
    @board_presenter ||= BoardPresenter.new(@game.board)
  end

  def opponent
    @game.players.detect { |player| player.user_id != @user.id }
  end

  def current_player
    @game.turns.last.player
  end
end
