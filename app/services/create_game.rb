class CreateGame
  include Shout

  def initialize(user)
    @user = user
  end

  def call
    game = Game.create(board_shape: :rhombus, board_size: 6)
    player = Player.create(user: @user, game: game)
    publish!(:success, game)
  end
end
