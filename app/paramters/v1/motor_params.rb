module V1
  class MotorParams
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def index
      values = []
      include = []
      columns = ''
      if params[:query].present? && params[:query].strip.presence
        columns += " #{columns.present? ? ' AND ' : ' '} motors.number_plate ILIKE ('%' || ? || '%') "
        values += [params[:query].strip.presence]
      end

      filter_values, filter, filter_joins = ::V1::FilterService.new(Motor, params).build_query_params
      filter = filter.strip.present? ? [filter, *filter_values] : []
      query =  columns.present? ? [columns, *values] : []
      { query: query, joins: filter_joins, filter: filter, include: include }
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
      @motor_params ||= params.permit(:model, :color, :chasis_number, :number_plate, :year, :brand, :person_id)
    end
  end
end
