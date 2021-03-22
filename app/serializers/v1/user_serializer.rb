module V1
  class UserSerializer
    include JSONAPI::Serializer

    attributes :id, :name, :username, :role, :number
  end
end
