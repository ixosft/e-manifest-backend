module V1
  class FilterService
    attr_reader :params, :filter
    def initialize(params)
      @params = params
      @filter = params[:filter]
    end

    def build_query_params
      return if filter.nil? ||  (params[:filter].present? &&filter[:columns].nil?) ||  (params[:filter].present? &&filter[:columns].nil?)

      columns = ''
      query = filter[:query]
      table = filter[:table]
      filter[:columns].each_with_index { |column, i| columns += " #{i > 0 ? ' OR ' : ' '}  #{table}.#{column} ILIKE ('%' || '#{query}' || '%')  " }
      columns
    end
  end
end