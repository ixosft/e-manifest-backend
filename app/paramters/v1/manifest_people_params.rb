module V1
  class ManifestPeopleParams
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def index
      values = []
      include = { person: [], manifest: %i[motor terminal company] }
      columns = ''
      filter_values, filter, filter_joins = ::V1::FilterService.new(ManifestPerson, params).build_query_params
      filter = filter.strip.present? ? [filter, *filter_values] : []
      query =  columns.present? ? [columns, *values] : []
      { query: query, joins: filter_joins, filter: filter, include: include }
    end
  end
end
