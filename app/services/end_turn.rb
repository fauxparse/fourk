class EndTurn
  def initialize(game)
    @game = game
  end

  def call
    StartTurn.new(@game).call
  end
end
