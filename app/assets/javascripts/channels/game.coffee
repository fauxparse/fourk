$ ->
  App.config = {
    channel: "GameChannel"
    game_id: $("meta[name=game-id]").attr("content")
    player_id: $("meta[name=player-id]").attr("content")
  }

  App.game = App.cable.subscriptions.create App.config,
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      switch data.action
        when "turn:start" then @startTurn(data.player)
        when "turn:play"  then @playTurn(data.turn)

    startTurn: (player) ->
      turn = if player.id.toString() == App.config.player_id
        "Your turn"
      else
        "#{player.name}’s turn"
      $("header .turn").text(turn)

    playTurn: (turn) ->
      (new App.PlayTurn(turn)).call()
