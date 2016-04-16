class JoinGame
  include Shout

  def initialize(user, game)
    @user = user
    @game = game
  end

  def call
    publish(:already_playing) and return if existing_player.present?
    publish(:full) and return if @game.full?

    @game.with_lock do
      begin
        player = Player.new(user: @user, game: @game)
        player.save!
        publish(:success)
      rescue ActiveRecord::RecordInvalid
        publish(:failure, player)
      end
    end
  end

  private

  def existing_player
    @existing_player ||= @game.players.find_by(user: @user)
  end
end
