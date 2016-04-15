class Hex
  attr_reader :x, :y, :z

  def initialize(x, y, z)
    raise ArgumentError, "co-ordinates must sum to 0" unless x + y + z == 0
    @x, @y, @z = x, y, z
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

  def to_a
    [x, y, z]
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
