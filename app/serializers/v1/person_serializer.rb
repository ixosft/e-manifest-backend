module V1
  class PersonSerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id full_name person_type nim sex next_of_kin_name next_of_kin_number number next_of_kin_relationship next_of_kin_address].freeze
    attributes(*ATTRIBUTES)
  end
end
