module V1
  class ManifestPersonSerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id manifest_id person_id destination_state destination_local_goverment].freeze
    attributes(*ATTRIBUTES)

    belongs_to :person
    belongs_to :manifest
  end
end
