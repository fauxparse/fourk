class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game, counter_cache: true

  acts_as_list scope: :game, top_of_list: 0

  delegate :name, :avatar, to: :user

  def to_s
    name
  end
end
