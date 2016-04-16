class OpenGamesWithoutUser
  def initialize(user)
    @user = user
  end

  def games
    Game.open
      .joins(:players)
      .where("players.user_id != ?", @user.id)
      .group("games.id")
      .having("COUNT(players.id) > 0")
      .distinct
  end
end
