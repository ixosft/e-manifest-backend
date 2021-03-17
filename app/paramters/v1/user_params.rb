# frozen_string_literal: true

module V1
  class UserParams
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def create
      { attrs: user_params }
    end

    private

    def user_params
      @user_params ||= params.permit(
        :name, :username, :terminal_id, :number, :email, :password
      )
    end
  end
end
