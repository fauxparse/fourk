class Game < ApplicationRecord
  validates :board_shape, :board_size,
    presence: true
  validates :board_size,
    numericality: { only_integer: true, greater_than: 0 }

  def board
    @board ||= Board.new(shape)
  end

  def number_of_colors
    4
  end

  def colors
    @colors ||= Color.first(number_of_colors)
  end

  private

  def shape
    Board.const_get(board_shape.to_s.camelize).new(board_size)
  end
end
