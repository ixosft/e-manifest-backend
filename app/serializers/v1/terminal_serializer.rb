module V1
  class TerminalSerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id name manager_id address state local_goverment].freeze
    attributes(*ATTRIBUTES)
  end
end
