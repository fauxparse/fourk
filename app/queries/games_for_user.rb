class GamesForUser
  def initialize(user)
    @user = user
  end

  def games
    Game
      .includes(players: :user)
      .joins(:players)
      .where("players.user_id = ? OR games.players_count < 2", @user.id)
  end
end
