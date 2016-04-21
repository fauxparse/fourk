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

  def meta_tags(values)
    values.each do |name, content|
      concat meta_tag(name, content)
    end
  end

  private

  def meta_tag(name, content)
    content_tag :meta, nil, name: name, content: content
  end
end
