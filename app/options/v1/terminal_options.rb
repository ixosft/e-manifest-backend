module V1
  class TerminalOptions
    attr_reader :params
    DEFAULT = {
      include: %I[manager],
      fields: {
        manager: %i[name id],
        terminal: V1::TerminalSerializer::ATTRIBUTES
      }
    }.freeze
    def initialize(params)
      @params = params
    end

    def update
      DEFAULT
    end

    def index(terminals)
      if params[:type] == 'for_dropdown'
        {
          include: [],
          fields: {
            terminal: %i[id name]
          }
        }
      else
        DEFAULT.merge({ meta: { cursor: terminals.cursor_before } })
      end
    end

    def create
      DEFAULT
    end
  end
end
