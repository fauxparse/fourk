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
      x1, z1, x2, z2 = hexes.inject([nil] * 4) do |(x1, z1), hex|
        [
          [x1, hex.x].compact.min,
          [z1, hex.z].compact.min,
          [x2, hex.x].compact.max,
          [z2, hex.z].compact.max,
        ]
      end
      x = (x1 + x2).to_d / 2
      z = (z1 + z2).to_d / 2
      Hex.new(x, -x - z, z)
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

  def each_hex(&block)
    hexes.each(&block)
  end

  def neighbours(hex)
    hex.neighbours & hexes
  end

  private

  def shape
    @shape
  end
end
