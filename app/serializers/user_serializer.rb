class UserSerializer < ActiveModel::Serializer
  has_many :apps

  attributes :id, :email
  link(:self) { api_v1_users_path(object) }
end