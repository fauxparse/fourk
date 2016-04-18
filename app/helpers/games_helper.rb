module GamesHelper
  def playing?(game, user = current_user)
    game.players.any? { |player| player.user_id == user.id }
  end

  def other_players(game, user = current_user)
    game.players.reject { |player| player.user_id == user.id }
  end

  def whose_turn(player)
    if player.user_id == current_user.id
      t("games.show.your_turn")
    else
      t("games.show.their_turn", opponent: player)
    end
  end
end
