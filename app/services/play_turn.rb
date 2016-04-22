class PlayTurn
  include Shout

  attr_accessor :params

  def initialize(game, player, move_params)
    @game = game
    @player = player
    @params = move_params.permit(:x, :y, :z, :color)
    @board_state = BoardState.new(@game)
  end

  def call
    raise(ArgumentError) unless turn.try(:player) == @player
    @game.with_lock do
      moves = [[initial_hex, initial_tile]]
      step = 0

      while moves.any?
        moves.each do |hex, tile|
          @board_state.board[hex] = tile
          turn.moves.create(hex: hex, color: move_color(tile), position: step)
        end
        moves = ForcedMoves.new(@board_state).moves
        step += 1
      end
    end
    publish(:success, turn)
    EndTurn.new(turn).call

    if @board_state.full?
      EndGame.new(@game).call
    else
      StartTurn.new(@game).call
    end
  end

  private

  def initial_hex
    Hex.new(*%i[x y z].map { |c| params[c].to_i })
  end

  def initial_tile
    Tile.new(Color[params[:color]])
  end

  def turn
    @turn ||= @game.turns.oldest_first.last
  end

  def move_color(tile)
    if tile.blocked?
      :black
    else
      tile.color.name
    end
  end
end
