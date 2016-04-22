class EndTurn
  attr_reader :turn
  delegate :game, :player, to: :turn

  def initialize(turn)
    @turn = turn
  end

  def call
    update_score
    GameChannel.broadcast_to game,
      action: "turn:play", turn: serialize_turn.as_json
  end

  private

  def serialize_turn
    ActiveModel::SerializableResource.new(turn)
  end

  def update_score
    player.with_lock do
      player.score += turn.score
      player.save!
    end
  end
end
