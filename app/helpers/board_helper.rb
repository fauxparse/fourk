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
      "data-z": hex.z
    }

    translate_group(*hex_to_pixel(hex, size), options) do
      concat hexagon(0, 0, size * 0.95)
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
      ("blank" if content.blank?)
    ].compact.join(" ")
  end
end
