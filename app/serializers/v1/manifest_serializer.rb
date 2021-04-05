module V1
  class ManifestSerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id destination_state source_state company_id terminal_id motor_id].freeze
    attributes(*ATTRIBUTES)

    belongs_to :motor
    belongs_to :terminal
    belongs_to :company
    has_many :manifest_people
    has_many :people, through: :manifest_people
  end
end
