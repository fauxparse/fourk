class StartTurn
  def initialize(game)
    @game = game
  end

  def call
    @turn = @game.turns.create(player: next_player)
  end

  private

  def next_player
    @game.players.detect { |player| player.position == next_player_position }
  end

  def next_player_position
    (@game.starting_player_position + @game.turns_count) % @game.players_count
  end
end
