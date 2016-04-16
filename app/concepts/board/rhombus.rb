class Board::Rhombus
  def initialize(size)
    @size = size
  end

  def hexes
    (0...@size).flat_map do |row|
      (0...@size).map do |column|
        Hex.from_axial(column, row)
      end
    end
  end
end
