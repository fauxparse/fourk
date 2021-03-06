class App.PlayTurn
  constructor: (turn) ->
    @turn = turn

  call: ->
    @playMove(move) for move in @turn.moves
    @updateScore()

  playMove: (move) ->
    [x, y, z] = move.position
    hex = $(".hex[data-x=#{x}][data-y=#{y}][data-z=#{z}]")
    hex.removeClass("blank").attr("data-step", move.step)
    hex.addClass("mine") if @turn.player.id.toString() == App.config.player_id
    if move.color == "black"
      hex.addClass("blocked")
    else
      hex.attr("data-color", move.color)

  updateScore: ->
    $("header [data-player-id=#{@turn.player.id}] .score")
      .text(@turn.player.score)
