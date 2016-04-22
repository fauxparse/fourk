class EndTurn
  attr_reader :turn
  delegate :game, to: :turn

  def initialize(turn)
    @turn = turn
  end

  def call
    GameChannel.broadcast_to game,
      action: "turn:play", turn: serialize_turn.as_json

    StartTurn.new(game).call
  end

  private

  def serialize_turn
    ActiveModel::SerializableResource.new(turn)
  end
end
