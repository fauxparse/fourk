class StartGame
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def call
    ready_to_start? &&
      game.update(state: :playing, starting_player_position: random_position) &&
      StartTurn.new(game).call
  end

  private

  def ready_to_start?
    game.full?
  end

  def random_position
    game.players.map(&:position).sample
  end
end
