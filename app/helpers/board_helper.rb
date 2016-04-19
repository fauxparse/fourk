module BoardHelper
  def board(board)
    x1, y1, x2, y2 = board.bounds
    scale = 1000.0 / [x2 - x1, y2 - y1].max
    scaled_svg(1000, 1000, class: "playing-area") do
      translate_group(*board.center.map { |x| x * -scale }, class: "board") do
        board.contents do |hex, contents|
          board_hex(hex, contents, scale * 2)
        end
      end
    end
  end

  def board_hex(hex, content, size)
    options = {
      class: hex_class(content),
      "data-x": hex.x,
      "data-y": hex.y,
      "data-z": hex.z,
      "data-color": content.color.presence,
      "data-poops": content.inspect
    }

    translate_group(*hex_to_pixel(hex, size), options) do
      concat hexagon(0, 0, size * 0.95, class: "hexagon")
    end
  end

  def palette(game, size = 56)
    colors = game.colors
    width = size * colors.length
    options = {
      class: "palette",
      width: width * 2,
      height: size * 2,
      viewBox: [-width, -size, width * 2, size * 2].join(" ")
    }
    svg(options) do
      colors.each.with_index do |color, index|
        x = index - (colors.length * 0.5) + 0.5
        concat hexagon(x * size, 0, size, class: "choose", "data-color": color)
      end
    end
  end

  private

  def hex_to_pixel(hex, size)
    [
      size / 2 * SvgHelper::ROOT_3 * (hex.x + hex.z * 0.5),
      size / 2 * 3.0 / 2 * hex.z
    ]
  end

  def hex_class(content)
    [
      "hex",
      ("blank" if content.blank?),
      ("blocked" if content.blocked?)
    ].compact.join(" ")
  end
end
