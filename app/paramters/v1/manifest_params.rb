module V1
  class ManifestParams
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def index
      values = []
      include = { company: [], motor: [], terminal: [], manifest_people: [:person] }
      columns = ''
      filter_values, filter, filter_joins = ::V1::FilterService.new(Manifest, params).build_query_params
      filter = filter.strip.present? ? [filter, *filter_values] : []
      query =  columns.present? ? [columns, *values] : []
      { query: query, joins: filter_joins, filter: filter, include: include }
    end

    def create
      { attrs: manifest_params }
    end

    def update
      { attrs: manifest_params }
    end

    private

    def manifest_params
      @manifest_params ||= params.permit(
        :id, :destination_state, :source_state, :company_id, :terminal_id, :motor_id, :source_terminal,
        :destination_terminal, :departure_time,
        manifest_people_attributes: %i[id manifest_id source_state source_terminal destination_state destination_terminal person_id _destroy]
      )
    end
  end
end
