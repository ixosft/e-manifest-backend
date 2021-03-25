module V1
  class TerminalOptions
    attr_reader :params
    DEFAULT = {
      include: %I[],
      fields: {
        terminal: V1::TerminalSerializer::ATTRIBUTES
      }
    }.freeze
    def initialize(params)
      @params = params
    end

    def index(terminals)
      DEFAULT.merge({ meta: { cursor: terminals.cursor_before } })
    end

    def create
      DEFAULT
    end
  end
end
