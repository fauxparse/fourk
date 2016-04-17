class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game, counter_cache: true

  delegate :name, :avatar, to: :user

  def to_s
    name
  end
end
