module V1
  class ManifestPeopleOptions
    attr_reader :params
    DEFAULT = {
      include: %I[person manifest source_terminal destination_terminal manifest.source_terminal manifest.destination_terminal manifest.company manifest.motor],
      fields: {
        company: %i[id name],
        person: V1::PersonSerializer::ATTRIBUTES,
        terminal: %i[name id state terminal],
        motor: %i[id number_plate brand],
        manifest: %i[id motor_id terminal_id],
        manifest_person: V1::ManifestPersonSerializer::ATTRIBUTES
      }
    }.freeze

    def initialize(params)
      @params = params
    end

    def index(manifest_people)
      DEFAULT.merge({ meta: { cursor: manifest_people.cursor_before } })
    end

    def create_ticket
      DEFAULT
    end

    def update_ticket
      DEFAULT
    end
  end
end
