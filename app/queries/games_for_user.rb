class GamesForUser
  def initialize(user)
    @user = user
  end

  def games(user)
    Game
      .includes(:players)
      .references(:players)
      .where("players.user_id = ?", @user.id)
  end
end
