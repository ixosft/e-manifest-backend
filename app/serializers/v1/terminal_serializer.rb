module V1
  class TerminalSerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id name manager_id address state terminal].freeze
    attributes(*ATTRIBUTES)

    belongs_to :manager, serializer: V1::UserSerializer
  end
end
