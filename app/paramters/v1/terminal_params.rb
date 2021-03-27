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
      filter = ''
      columns = ''
      { query: [], joins: joins, filter: filter }
    end

    def create
      { attrs: terminal_params }
    end

    private

    def terminal_params
      @terminal_params ||= params.permit(:name, :address, :state, :local_goverment, :manager_id)
    end
  end
end
