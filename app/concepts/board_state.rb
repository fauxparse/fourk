class BoardState
  attr_accessor :board, :colors
  delegate :[], :[]=, :hexes, :full?, to: :board

  def initialize(game)
    @board = Board.new(game.shape)
    @colors = game.colors
    game.moves.each do |move|
      board[move.hex] = move.tile
    end
  end
end
