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
    @game.players.detect { |player| player.user_id != @user.id }
  end

  def player
    @game.players.detect { |player| player.user_id == @user.id }
  end

  def current_player
    @game.turns.last.player
  end

  def colors
    @game.colors.map(&:name)
  end
end
