class Hex
  attr_reader :x, :y, :z

  def initialize(x, y, z)
    @x, @y, @z = x, y, z
    raise ArgumentError, "co-ordinates must sum to 0" unless zero?
  end

  def ==(another)
    to_a == another.to_a
  end

  def +(another)
    Hex.new(x + another.x, y + another.y, z + another.z)
  end

  def -(another)
    Hex.new(x - another.x, y - another.y, z - another.z)
  end

  def -@
    Hex.new(-x, -y, -z)
  end

  def *(scale)
    Hex.new(x * scale, y * scale, z * scale)
  end

  def /(scale)
    self * (1 / scale)
  end

  def to_a
    [x, y, z]
  end

  def zero?
    # to cope with fractional co-ordinates
    (x + y + z).abs < 1e-6
  end

  def round
    rx, ry, rz = to_a.map(&:round)
    dx = (rx - x).round
    dy = (ry - y).round
    dz = (rz - z).round

    if dx > dy && dx > dz
      rx = -ry - rz
    elsif dy > dz
      ry = -rx - rz
    else
      rz = -rx - ry
    end

    Hex.new(rx, ry, rz)
  end

  def neighbours
    self.class.directions.map { |direction| self + direction }
  end

  def self.origin
    new(0, 0, 0)
  end

  def self.from_axial(q, r)
    new(q, -q - r, r)
  end

  def self.directions
    @directions ||= [
      new( 1, -1,  0).freeze, new( 1,  0, -1).freeze, new( 0,  1, -1).freeze,
      new(-1,  1,  0).freeze, new(-1,  0,  1).freeze, new( 0, -1,  1).freeze
    ].freeze
  end
end
