class PlayTurn
  def initialize(game, player, move_params)
    @game = game
    @player = player
    @params = move_params
  end

  def call
    raise(ArgumentError) unless turn.try(:player) == @player
    turn.moves.create(params)
    EndTurn.new(@game).call
  end

  private

  def turn
    @turn ||= @game.turns.oldest_first.last
  end

  def params
    @params.permit(:x, :y, :z, :color)
  end
end
