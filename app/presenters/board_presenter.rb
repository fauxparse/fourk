class BoardPresenter
  attr_reader :board

  delegate :center, to: :board

  def initialize(board)
    @board = board
  end

  def contents
    board.hexes.map do |hex|
      yield hex, board[hex]
    end
  end

  def bounds
    board.hexes.inject([nil, nil, nil, nil]) do |(x1, y1, x2, y2), hex|
      x, y = hex_to_xy(hex)
      [
        [x1, x - 2].compact.min,
        [y1, y - 2].compact.min,
        [x2, x + 2].compact.max,
        [y2, y + 2].compact.max
      ]
    end
  end

  private

  ROOT_3 = 1.7320508075688772

  def hex_to_xy(hex)
    [
      ROOT_3 * (hex.x + hex.z * 0.5),
      1.5 * hex.z
    ]
  end
end
