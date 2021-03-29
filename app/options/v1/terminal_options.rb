module V1
  class TerminalOptions
    attr_reader :params
    DEFAULT = {
      include: %I[manager],
      fields: {
        manager: [:name, :id],
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
      DEFAULT.merge({ meta: { cursor: terminals.cursor_before } })
    end

    def create
      DEFAULT
    end
  end
end
