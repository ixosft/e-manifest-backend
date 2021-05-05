module V1
  class ManifestOptions
    attr_reader :params
    DEFAULT = {
      include: %I[company motor terminal manifest_people manifest_people.person],
      fields: {
        company: %i[id name],
        person: V1::PersonSerializer::ATTRIBUTES,
        terminal: %i[name id state terminal],
        manifest: V1::ManifestSerializer::ATTRIBUTES,
        motor: %i[id number_plate brand],
        manifest_person: V1::ManifestPersonSerializer::ATTRIBUTES
      }
    }.freeze

    def initialize(params)
      @params = params
    end

    def index(manifests)
      DEFAULT.merge({ meta: { cursor: manifests.cursor_before } })
    end

    def update
      DEFAULT
    end

    def show
      DEFAULT
    end

    def create
      DEFAULT
    end
  end
end
