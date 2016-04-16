class Board::Hexagon
  def initialize(size)
    @size = size
  end

  def hexes
    n = @size - 1
    (-n..n).flat_map do |row|
      ((-n - [0, row].min)..(n - [0, row].max)).map do |column|
        Hex.from_axial(column, row)
      end
    end
  end
end
