module V1
  class PersonOptions
    attr_reader :params
    DEFAULT = {
      include: %I[],
      fields: {
        company: V1::PersonSerializer::ATTRIBUTES
      }
    }.freeze

    def initialize(params)
      @params = params
    end

    def index(people)
      if params[:type] == 'for_dropdown'
        {
          include: [],
          fields: {
            person: %i[id name]
          }
        }
      else
        DEFAULT.merge({ meta: { cursor: people.cursor_before } })
      end
    end

    def update
      DEFAULT
    end

    def create
      DEFAULT
    end
  end
end
