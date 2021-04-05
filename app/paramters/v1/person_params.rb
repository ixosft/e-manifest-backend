module V1
  class PersonParams
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def index
      joins = []
      values = []
      include = []
      columns = ''
      if params[:type] == 'for_driver_dropdown'
        columns += ' people.person_type = ? '
        values << Person.person_types[:driver]
      end

      if params[:query].present? && params[:query].strip.presence
        columns += " #{columns.present? ? ' AND ' : ' '} people.full_name ILIKE ('%' || ? || '%') "
        values += [params[:query].strip.presence]
      end

      filter_values, filter = ::V1::FilterService.new(params).build_query_params
      filter = filter.strip.present? ? [filter, *filter_values] : []
      query =  columns.present? ? [columns, *values] : []
      { query: query, joins: joins, filter: filter, include: include }
    end

    def create
      { attrs: person_params }
    end

    def update
      { attrs: person_params }
    end

    private

    def person_params
      @person_params ||= params.permit(:full_name, :person_type, :next_of_kin_name, :next_of_kin_number, :next_of_kin_relationship, :next_of_kin_address, :number)
    end
  end
end
