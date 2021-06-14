module V1
  class ManifestSerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id destination_state source_state company_id closed terminal_id motor_id source_terminal_id destination_terminal_id departure_time].freeze
    attributes(*ATTRIBUTES)

    belongs_to :motor
    belongs_to :terminal
    belongs_to :company
    has_many :manifest_people
    has_many :people, through: :manifest_people
    belongs_to :source_terminal, serializer: V1::TerminalSerializer
    belongs_to :destination_terminal, serializer: V1::TerminalSerializer
  end
end
