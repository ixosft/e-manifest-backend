module V1
  class CompanySerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id name address manager_name number].freeze
    attributes(*ATTRIBUTES)
  end
end
