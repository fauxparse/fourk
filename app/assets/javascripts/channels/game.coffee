$ ->
  config = {
    channel: "GameChannel"
    game_id: $("meta[name=game-id]").attr("content")
    player_: $("meta[name=player-id]").attr("content")
  }

  console.log config

  App.game = App.cable.subscriptions.create config,
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      if data.action == "turn"
        @startTurn(data.player)

    play: ->
      @perform 'play'

    startTurn: (player) ->
      turn = if player.id.toString() == config.player_id
        "Your turn"
      else
        "#{player.name}’s turn"
      $("header .turn").text(turn)
