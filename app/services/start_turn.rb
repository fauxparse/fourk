class StartTurn
  def initialize(game)
    @game = game
  end

  def call
    @turn = @game.turns.create(player: next_player)
    GameChannel.broadcast_to @game,
      action: "turn", player: serialize_player(@turn.player).as_json
  end

  private

  def next_player
    @game.players.detect { |player| player.position == next_player_position }
  end

  def next_player_position
    (@game.starting_player_position + @game.turns_count) % @game.players_count
  end

  def serialize_player(player)
    ActiveModel::SerializableResource.new(player)
  end
end
