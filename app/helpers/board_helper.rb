module BoardHelper
  def board(board)
    x1, y1, x2, y2 = board.bounds
    scale = 1000.0 / [x2 - x1, y2 - y1].max * 2
    scaled_svg(1000, 1000) do
      translate_group(*hex_to_pixel(-board.center, scale)) do
        board.contents do |hex, contents|
          board_hex(hex, contents, scale)
        end
      end
    end
  end

  def board_hex(hex, contents, size)
    translate_group(*hex_to_pixel(hex, size)) do
      concat hexagon(0, 0, size, fill: "white", stroke: "black")
    end
  end

  private

  def hex_to_pixel(hex, size)
    [
      size / 2 * SvgHelper::ROOT_3 * (hex.x + hex.z * 0.5),
      size / 2 * 3.0 / 2 * hex.z
    ]
  end
end
