module V1
  class ManifestPeopleSerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id destination_state total_trip_to people_count total_motors total_terminal total_people total_companies total_users].freeze
    attributes(*ATTRIBUTES)
  end
end
