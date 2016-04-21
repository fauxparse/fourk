class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar

  def avatar
    object.user.avatar
  end
end
