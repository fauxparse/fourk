class Board::Star
  def initialize(size)
    @size = size
  end

  def hexes
    triangle = Board::Triangle.new(@size)
    r = @size * 2 / 3
    translate = Hex.new(r, r * -2, r)
    triangle.hexes | triangle.hexes.map { |hex| translate - hex }
  end
end
