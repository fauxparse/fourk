class Tile
  attr_reader :color

  def initialize(color)
    @color = color
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
end
