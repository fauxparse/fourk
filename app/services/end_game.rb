class EndGame
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def call
    game.update!(state: :finished)
    GameChannel.broadcast_to game,
      action: "game:end", game: serialize_game.as_json
  end

  private

  def serialize_game
    ActiveModel::SerializableResource.new(game)
  end
end
