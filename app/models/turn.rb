class Turn < ApplicationRecord
  belongs_to :game, inverse_of: :turns, counter_cache: true
  belongs_to :player
  has_many :moves, inverse_of: :turn

  acts_as_list scope: :game, top_of_list: 0

  scope :oldest_first, -> { order(position: :asc) }

  validates :player,
    inclusion: { within: ->(turn) { turn.game.players } }
end
