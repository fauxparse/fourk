class Move < ApplicationRecord
  belongs_to :turn, counter_cache: true
  has_one :game, through: :turn

  enum color: { black: "black" }.merge(Color::HASH)

  acts_as_list scope: :turn, top_of_list: 0

  validates :turn, presence: true

  validates :x, :y, :z,
    presence: true,
    numericality: { only_integer: true }

  validate :unique_move, on: :create

  def hex
    Hex.new(x, y, z)
  end

  private

  def unique_move
    errors.add(:base, "hex is already occupied") if hex_is_occupied?
  end

  def hex_is_occupied?
    game.moves.where(x: x, y: y, z: z).exists?
  end
end
