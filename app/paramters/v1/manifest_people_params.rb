module V1
  class ManifestPeopleParams
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def index
      joins = []
      values = []
      include = { person: [], manifest: %i[motor terminal company] }
      columns = ''
      filter_values, filter = ::V1::FilterService.new(params).build_query_params
      filter = filter.strip.present? ? [filter, *filter_values] : []
      query =  columns.present? ? [columns, *values] : []
      { query: query, joins: joins, filter: filter, include: include }
    end
  end
end
