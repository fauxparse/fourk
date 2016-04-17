class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :users, through: :players

  enum state: {
    waiting_for_players: "waiting_for_players",
    playing: "playing",
    finished: "finished"
  }

  validates :board_shape, :board_size,
    presence: true
  validates :board_size,
    numericality: { only_integer: true, greater_than: 0 }
  validates :starting_player_position,
    inclusion: {
      in: ->(game) { game.players.map(&:position) },
      allow_blank: true
    }

  scope :open, -> { where("players_count < 2") }
  scope :oldest_first, -> { order(created_at: :asc) }

  def board
    @board ||= Board.new(shape)
  end

  def number_of_colors
    4
  end

  def maximum_number_of_players
    2
  end

  def full?
    players.count >= maximum_number_of_players
  end

  def open?
    players.count < maximum_number_of_players
  end

  def colors
    @colors ||= Color.first(number_of_colors)
  end

  private

  def shape
    Board.const_get(board_shape.to_s.camelize).new(board_size)
  end
end
