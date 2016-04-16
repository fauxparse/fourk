class Board
  attr_reader :hexes

  delegate :include?, to: :hexes

  def initialize(shape)
    @hexes = shape.hexes
    @occupants = {}
  end

  def center
    @center ||= hexes.inject(&:+) * 0.5
  end

  def [](hex)
    raise ArgumentError, "co-ordinates out of bounds" unless include?(hex)
    @occupants[hex.to_a]
  end

  def []=(hex, value)
    raise ArgumentError, "co-ordinates out of bounds" unless include?(hex)
    @occupants[hex.to_a] = value
  end

  def empty?
    hexes.all? { |hex| self[hex].blank? }
  end
end
