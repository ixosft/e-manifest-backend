module V1
  class ManifestPersonSerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id manifest_id person_id destination_state destination_local_goverment total_trip_to people_count total_motors total_terminal total_people total_companies total_users].freeze
    attributes(*ATTRIBUTES)

    belongs_to :person
    belongs_to :manifest
  end
end
