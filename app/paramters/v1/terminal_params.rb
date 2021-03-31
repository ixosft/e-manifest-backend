# frozen_string_literal: true

module V1
  class TerminalParams
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def index
      joins = []
      values = []
      include = []
      columns = ''
      if params[:type] == 'for_dropdown'
        columns += " terminals.name ILIKE ('%' || ? || '%') "
        values += [params[:query]]
      else
        include << :manager
      end
      filter = ::V1::FilterService.new(params).build_query_params || ''
      query =  columns.present? ? [columns, *values] : []
      { query: query, joins: joins, filter: filter, include: include }
    end

    def create
      { attrs: terminal_params }
    end

    def update
      { attrs: terminal_params }
    end

    private

    def terminal_params
      @terminal_params ||= params.permit(:name, :address, :state, :local_goverment, :manager_id)
    end
  end
end
