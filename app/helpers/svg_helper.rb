module SvgHelper
  ROOT_3 = 1.7320508075688772
  ROOT_3_OVER_2 = 0.8660254037844386

  def svg(options = {}, &block)
    content_tag :svg, options.reverse_merge(default_svg_options), &block
  end

  def scaled_svg(width, height, options = {}, &block)
    svg_options = {
      preserveAspectRatio: "xMidYMid meet",
      viewBox: "#{width / -2} #{height / -2} #{width} #{height}"
    }
    svg(svg_options.merge(options), &block)
  end

  def hexagon(x, y, height, options = {})
    width = height * ROOT_3_OVER_2
    polygon(
      [
        [x + width / 2, y - height / 4],
        [x, y - height / 2],
        [x - width / 2, y - height / 4],
        [x - width / 2, y + height / 4],
        [x, y + height / 2],
        [x + width / 2, y + height / 4]
      ],
      options
    )
  end

  def polygon(points, options = {})
    options[:points] = points.map { |point| point.join(",") }.join(" ")
    content_tag :polygon, nil, options
  end

  def translate_group(x, y, &block)
    concat content_tag(:g, nil, transform: "translate(#{x}, #{y})", &block)
  end

  private

  def default_svg_options
    { xmlns: "http://www.w3.org/2000/svg", version: "1.1" }
  end
end
