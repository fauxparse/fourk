class GamesForUser
  def initialize(user)
    @user = user
  end

  def games
    Game
      .oldest_first
      .joins(:players)
      .where("(state = ? AND players.user_id = ?) OR games.players_count < 2", :playing, @user.id)
  end
end
