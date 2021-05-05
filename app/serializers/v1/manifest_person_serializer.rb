module V1
  class ManifestPersonSerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id manifest_id person_id destination_state source_state source_terminal destination_terminal total_trip_to people_count total_motors total_terminal total_people total_companies total_users].freeze
    attributes(*ATTRIBUTES)

    belongs_to :person
    belongs_to :manifest
  end
end
