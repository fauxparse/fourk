class App.SendMove
  constructor: (hex, color) ->
    @hex = hex
    @color = color

  call: ->
    @hex
      .removeClass("blank")
      .addClass("mine")
      .attr("data-color", @color)
    $.ajax
      url: "#{location.pathname}/moves",
      method: "post",
      data:
        move:
          x: @hex.data("x")
          y: @hex.data("y")
          z: @hex.data("z")
          color: @color
