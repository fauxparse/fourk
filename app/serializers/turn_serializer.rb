class TurnSerializer < ActiveModel::Serializer
  has_one :player
  has_many :moves
end
