class Tile
  attr_reader :color
  attr_accessor :player_id

  def initialize(color, player_id = nil)
    @color = color
    @player_id = player_id
  end

  def blank?
    false
  end

  def blocked?
    false
  end

  def ==(another)
    color == another.color
  end

  def belongs_to?(player)
    player_id == player.id
  end
end
