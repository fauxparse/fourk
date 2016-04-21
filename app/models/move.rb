class Move < ApplicationRecord
  belongs_to :turn, inverse_of: :moves, counter_cache: true
  has_one :game, through: :turn

  composed_of :hex, mapping: [%w(x x), %w(y y), %w(z z)]

  enum color: { black: "black" }.merge(Color::HASH)

  acts_as_list scope: :turn, top_of_list: 0

  validates :turn, presence: true

  validates :x, :y, :z,
    presence: true,
    numericality: { only_integer: true }

  validate :unique_move, on: :create

  def tile
    if black?
      Blockage.new
    else
      Tile.new(Color[color], turn.player_id)
    end
  end

  private

  def unique_move
    errors.add(:base, "hex is already occupied") if hex_is_occupied?
  end

  def hex_is_occupied?
    game.moves.where(x: x, y: y, z: z).exists?
  end
end
