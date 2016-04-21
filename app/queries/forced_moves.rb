class ForcedMoves
  attr_accessor :state

  delegate :board, :colors, to: :state

  def initialize(board_state)
    @state = board_state
  end

  def moves
    forced = detect_forced_moves
    detect_blockages(forced).each { |hex| forced[hex.to_a] = Blockage.new }
    hash_to_array(forced)
  end

  private

  def detect_forced_moves
    board.each_hex.with_object({}) do |hex, moves|
      next unless board[hex].blank?

      neighbours = board.neighbours(hex)
        .map { |h| board[h].color }
        .compact.uniq

      if neighbours.length == colors.length
        moves[hex.to_a] = Blockage.new
      elsif neighbours.length == colors.length - 1
        moves[hex.to_a] = Tile.new((colors - neighbours).first)
      end
    end
  end

  def detect_blockages(forced)
    hash_to_array(forced).combination(2).with_object([]) do |(a, b), blockages|
      hex_a, tile_a = a
      hex_b, tile_b = b
      if tile_a == tile_b && !tile_a.blocked? && hex_a.adjacent_to?(hex_b)
        blockages << hex_a
        blockages << hex_b
      end
    end
  end

  def hash_to_array(hash)
    hash.map { |(x, y, z), tile| [Hex.new(x, y, z), tile] }
  end
end
