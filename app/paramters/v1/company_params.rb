module V1
  class CompanyParams
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def index
      joins = []
      values = []
      include = []
      columns = ''
      filter_values, filter = ::V1::FilterService.new(params).build_query_params
      filter = filter.strip.present? ? [filter, *filter_values] : []
      query =  columns.present? ? [columns, *values] : []
      { query: query, joins: joins, filter: filter, include: include }
    end

    def create
      { attrs: company_params }
    end

    def update
      { attrs: company_params }
    end

    private

    def company_params
      @company_params ||= params.permit(:name, :address, :manager_name, :number)
    end
  end
end
