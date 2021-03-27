# frozen_string_literal: true

module V1
  class UserOptions
    attr_reader :params

    DEFAULT = {
      include: %I[],
      fields: {
        user: %I[id name username]
      }
    }.freeze

    def initialize(params)
      @params = params
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
        DEFAULT
      end
    end

    def auth
      DEFAULT
    end
  end
end
