$(function() {
  let palette = $(".palette");
  let paletteWidth = parseInt(palette.attr("width"), 10);
  let paletteHeight = parseInt(palette.attr("height"), 10);

  $('.playing-area').on('mousedown touchstart', function(e) {
    let hex = $(e.target).closest('.blank.hex');

    if (hex.length) {
      hex.addClass("active");
      let neighbours = getNeighbours(hex);
      let colors = neighbours.map((_, hex) => $(hex).data("color")).get();

      palette.find("[disabled]").removeAttr("disabled").end()
      colors.forEach((color) =>
        palette.find(`[data-color=${color}]`).attr("disabled", true)
      );

      let [x, y] = getEventCoordinates(e);
      palette
        .css({ left: x - paletteWidth / 2, top: y - paletteHeight / 2 })
        .addClass("active");

      $(window).one('mouseup touchend', function(e) {
        let chosen = $(e.target).closest(".choose");
        if (chosen.length) {
          hex.removeClass("blank").attr("data-color", chosen.data("color"));
        }
        palette.removeClass("active")
          .find("polygon").removeClass("hover").end();
        hex.removeClass("active");
      });
    }
  });

  $(".palette").on("mousemove touchmove", "polygon", function(e) {
    $(e.target).closest("polygon").addClass("hover")
      .siblings().removeClass("hover").end();
  });

  function getEventCoordinates(event) {
    if (event.originalEvent.touches) {
      return getEventCoordinates(event.originalEvent.touches[0]);
    } else {
      return [event.pageX, event.pageY];
    }
  }

  let NEIGHBOURS = [
    [ 1, -1,  0],
    [ 1,  0, -1],
    [ 0,  1, -1],
    [-1,  1,  0],
    [-1,  0,  1],
    [ 0, -1,  1]
  ]

  function getNeighbours(hex) {
    let [x, y, z] = ["x", "y", "z"].map((a) => parseInt(hex.data(a), 10));
    return $(NEIGHBOURS.map(
      ([dx, dy, dz]) => `.hex[data-x=${x+dx}][data-y=${y+dy}][data-z=${z+dz}]`
    ).join(", "));
  }
});
