class Turn < ApplicationRecord
  belongs_to :game, inverse_of: :turns, counter_cache: true
  belongs_to :player

  acts_as_list scope: :game, top_of_list: 0

  validates :player,
    inclusion: { within: ->(turn) { turn.game.players } }
end
