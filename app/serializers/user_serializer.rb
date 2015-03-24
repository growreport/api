UserSerializers < ActiveModel::Serializer
  attributes :id, :username, :email

  has_many :groups, :posts
end