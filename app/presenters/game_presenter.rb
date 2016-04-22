class GamePresenter
  def initialize(game, user)
    @game = game
    @user = user
  end

  def id
    @game.id
  end

  def board
    @board_presenter ||= BoardPresenter.new(@game, player)
  end

  def opponent
    players.detect { |player| player.user_id != @user.id }
  end

  def player
    players.detect { |player| player.user_id == @user.id }
  end

  def players
    @game.players
  end

  def current_player
    @game.turns.last.player
  end

  def colors
    @game.colors.map(&:name)
  end

  def finished?
    @game.finished?
  end
end
