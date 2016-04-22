class GameSerializer < ActiveModel::Serializer
  attributes :id, :state
  has_many :players
end
