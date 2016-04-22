class TurnSerializer < ActiveModel::Serializer
  attributes :score
  has_one :player
  has_many :moves
end
