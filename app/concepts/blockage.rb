class Blockage < Tile
  def initialize
    super nil
  end

  def blocked?
    true
  end

  def ==(another)
    another.blocked?
  end
end
