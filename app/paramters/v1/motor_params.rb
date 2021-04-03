module V1
  class MotorParams
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
      { attrs: motor_params }
    end

    def update
      { attrs: motor_params }
    end

    def validate_number_plate
      columns = 'number_plate = ?'
      values = [params[:number_plate]]
      if params[:id]
        columns += ' and id != ?'
        values << params[:id]
      end
      { query: [columns, *values] }
    end

    private

    def motor_params
      @motor_params ||= params.permit(:model, :color, :chasis_number, :number_plate, :year, :brand)
    end
  end
end
