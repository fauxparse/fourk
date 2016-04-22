class MoveSerializer < ActiveModel::Serializer
  attributes :position, :step, :color

  def position
    object.hex.to_a
  end

  def step
    object.position
  end

  def color
    (object.tile.color || :black).to_s
  end
end
