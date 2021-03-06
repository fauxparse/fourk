class BoardPresenter
  attr_reader :board, :player

  def initialize(game, player)
    @game = game
    @player = player
    @board = BoardState.new(game)
  end

  def contents
    board.hexes.map do |hex|
      yield hex, board[hex]
    end
  end

  def bounds
    @bounds ||= begin
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
  end

  def center
    x1, y1, x2, y2 = bounds
    [(x1 + x2) / 2.0, (y1 + y2) / 2.0]
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
