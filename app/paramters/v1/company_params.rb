module V1
  class CompanyParams
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def index
      values = []
      include = []
      columns = ''

      if params[:query].present? && params[:query].strip.presence
        columns += " #{columns.present? ? ' AND ' : ' '} companies.name ILIKE ('%' || ? || '%') "
        values += [params[:query].strip.presence]
      end

      filter_values, filter, filter_joins = ::V1::FilterService.new(Company, params).build_query_params
      filter = filter.strip.present? ? [filter, *filter_values] : []
      query =  columns.present? ? [columns, *values] : []
      { query: query, joins: filter_joins, filter: filter, include: include }
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
