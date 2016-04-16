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
    @center ||= begin
      x1, y1, z1, x2, y2, z2 = hexes.inject([nil] * 6) do |(x1, y1, z1), hex|
        [
          [x1, hex.x].compact.min,
          [y1, hex.y].compact.min,
          [z1, hex.z].compact.min,
          [x2, hex.x].compact.max,
          [y2, hex.y].compact.max,
          [z2, hex.z].compact.max,
        ]
      end
      Hex.new((x1 + x2) / 2, (y1 + y2) / 2, (z1 + z2) / 2)
    end
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
