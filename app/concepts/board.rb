class Board
  attr_reader :hexes

  delegate :size, to: :shape
  delegate :include?, to: :hexes

  def initialize(shape)
    @shape = shape
    @hexes = shape.hexes
    @occupants = Hash.new(Blank.new)
  end

  def center
    @center ||= hexes.inject(&:+) / hexes.length
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

  private

  def shape
    @shape
  end
end
