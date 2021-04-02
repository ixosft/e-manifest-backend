module V1
  class FilterService
    attr_reader :params, :filter
    def initialize(params)
      @params = params
      @filter = params[:filter] || {}
    end

    def build_query_params
      if !filter[:query].present? || filter.nil? || (params[:filter].present? && filter[:columns].nil?) || (params[:filter].present? && filter[:columns].nil?)
        return [[], '']
      end

      columns = ''
      query = filter[:query]
      table = filter[:table]
      values = []
      filter[:columns].each_with_index do |column, i|
        columns += " #{i.positive? ? ' OR ' : ' '}  #{table}.#{column} ILIKE ('%' || ? || '%')  "
        values << query
      end
      [values, columns]
    end
  end
end
