module V1
  class MotorOptions
    attr_reader :params
    DEFAULT = {
      include: %I[onwer],
      fields: {
        onwer: %i[id full_name],
        motor: V1::MotorSerializer::ATTRIBUTES
      }
    }.freeze

    def initialize(params)
      @params = params
    end

    def index(motors)
      if params[:type] == 'for_dropdown'
        {
          include: [],
          fields: {
            motor: %i[id number_plate]
          }
        }
      else
        DEFAULT.merge({ meta: { cursor: motors.cursor_before } })
      end
    end

    def update
      DEFAULT
    end

    def create
      DEFAULT
    end
  end
end
