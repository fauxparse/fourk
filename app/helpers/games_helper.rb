module GamesHelper
  def playing?(game, user = current_user)
    game.players.any? { |player| player.user_id == user.id }
  end

  def other_players(game, user = current_user)
    game.players.reject { |player| player.user_id == user.id }
  end
end
