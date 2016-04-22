class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :score

  def avatar
    object.user.avatar
  end
end
