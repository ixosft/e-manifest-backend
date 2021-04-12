module V1
  class ManifestOptions
    attr_reader :params
    DEFAULT = {
      include: %I[company motor terminal manifest_people manifest_people.person],
      fields: {
        company: %i[id name],
        motor: %i[id chasis_number number_plate brand],
        person: V1::PersonSerializer::ATTRIBUTES,
        terminal: %i[name id state local_goverment],
        manifest_person: %i[id person_id manifest_id destination_state destination_local_goverment],
        manifest: V1::ManifestSerializer::ATTRIBUTES
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
