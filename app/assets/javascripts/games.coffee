$ ->
  palette = $(".palette")
  paletteWidth = parseInt(palette.attr("width"), 10)
  paletteHeight = parseInt(palette.attr("height"), 10)

  $(".playing-area").on "mousedown touchstart", (e) ->
    hex = $(e.target).closest(".blank.hex")

    if hex.length
      hex.addClass("active")
      neighbours = getNeighbours(hex)
      colors = neighbours.map((_, hex) -> $(hex).data("color")).get()

      palette.find("[disabled]").removeAttr("disabled").end()
      for color in colors
        palette.find("[data-color=#{color}]").attr("disabled", true)

      [x, y] = getEventCoordinates(e)
      palette
        .css({ left: x - paletteWidth / 2, top: y - paletteHeight / 2 })
        .addClass("active")

      $(window).one "mouseup touchend", (e) ->
        chosen = $(e.target).closest(".choose")
        if chosen.length
          (new App.SendMove(hex, chosen.data("color"))).call()

        palette.removeClass("active")
          .find("polygon").removeClass("hover").end()
        hex.removeClass("active")

  $(".palette").on "mousemove touchmove", "polygon", (e) ->
    $(e.target).closest("polygon").addClass("hover")
      .siblings().removeClass("hover").end()

  getEventCoordinates = (event) ->
    if event.originalEvent.touches
      getEventCoordinates(event.originalEvent.touches[0])
    else
      [event.pageX, event.pageY]

  NEIGHBOURS = [
    [ 1, -1,  0],
    [ 1,  0, -1],
    [ 0,  1, -1],
    [-1,  1,  0],
    [-1,  0,  1],
    [ 0, -1,  1]
  ]

  getNeighbours = (hex) ->
    [x, y, z] = (parseInt(hex.data(a), 10) for a in ["x", "y", "z"])
    $(NEIGHBOURS.map(
      ([dx, dy, dz]) -> ".hex[data-x=#{x+dx}][data-y=#{y+dy}][data-z=#{z+dz}]"
    ).join(", "))
