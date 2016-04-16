class GamePresenter
  def initialize(game)
    @game = game
  end

  def board
    @board_presenter ||= BoardPresenter.new(@game.board)
  end
end
