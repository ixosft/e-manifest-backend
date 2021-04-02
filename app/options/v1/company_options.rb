module V1
  class CompanyOptions
    attr_reader :params
    DEFAULT = {
      include: %I[],
      fields: {
        company: V1::CompanySerializer::ATTRIBUTES
      }
    }.freeze

    def initialize(params)
      @params = params
    end

    def index(companies)
      if params[:type] == 'for_dropdown'
        {
          include: [],
          fields: {
            terminal: %i[id name]
          }
        }
      else
        DEFAULT.merge({ meta: { cursor: companies.cursor_before } })
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
