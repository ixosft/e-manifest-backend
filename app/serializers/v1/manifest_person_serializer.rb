module V1
  class ManifestPersonSerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id manifest_id amount ticket_uid person_id destination_state source_state source_terminal_id destination_terminal_id total_trip_to people_count total_motors total_terminal total_people total_companies total_users].freeze
    attributes(*ATTRIBUTES)

    belongs_to :person
    belongs_to :manifest
    belongs_to :source_terminal, serializer: V1::TerminalSerializer
    belongs_to :destination_terminal, serializer: V1::TerminalSerializer
  end
end
