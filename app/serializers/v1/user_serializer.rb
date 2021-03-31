module V1
  class UserSerializer
    include JSONAPI::Serializer

    attributes :id, :name, :username, :role, :number, :active, :email, :terminal_id

    belongs_to :terminal
  end
end
