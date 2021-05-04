# frozen_string_literal: true

module V1
  class UserOptions
    attr_reader :params

    DEFAULT = {
      include: %I[terminal],
      fields: {
        terminal: %i[id name],
        user: %I[id name email username role number terminal_id active]
      }
    }.freeze

    def initialize(params)
      @params = params
    end

    def update
      DEFAULT
    end

    def register
      DEFAULT
    end

    def index(users)
      if params[:type] == 'for_user_dropdown'
        {
          include: %I[],
          fields: {
            user: %I[id name]
          },
          meta: { cursor: users.cursor_before }
        }
      else
        DEFAULT.merge({ meta: { cursor: users.cursor_before } })
      end
    end

    def auth
      {
        include: %I[],
        fields: {
          user: %I[id name email username role number permission_graph]
        }
      }
    end
  end
end
