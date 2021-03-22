# frozen_string_literal: true

module V1
  class UserOptions
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def auth
      {
        include: %I[],
        fields: {
          user: %I[id name username]
        }
      }
    end
  end
end
