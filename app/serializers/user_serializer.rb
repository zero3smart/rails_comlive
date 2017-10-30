class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_many :apps
  link(:self) { api_v1_users_path(object) }
end