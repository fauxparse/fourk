class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game, counter_cache: true

  delegate :name, :avatar, to: :user
end
