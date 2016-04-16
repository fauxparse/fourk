class Board::Triangle
  def initialize(size)
    @size = size
  end

  def hexes
    (0...@size).flat_map do |row|
      (0...(@size - row)).map { |column| Hex.from_axial(row, column) }
    end
  end
end
