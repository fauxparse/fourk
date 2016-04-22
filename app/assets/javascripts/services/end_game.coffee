class App.EndGame
  constructor: (game) ->
    @game = game

  call: ->
    $(".game-result")
      .find(".winner[data-player-id=#{@winner()}]").show().end()
      .addClass("show")

  winner: ->
    highest = winner = -1
    for player in @game.players
      if player.score > highest
        highest = player.score
        winner = player.id
    winner
