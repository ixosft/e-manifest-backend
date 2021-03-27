# frozen_string_literal: true

module V1
  class UserParams
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def index
      joins = []
      values = []
      filter = ''
      columns = ''

      # TODO: add index to role, role and name, role and username, username, name
      if params[:type] == "for_user_dropdown"
        columns += " users.role in (?) "
        values << [User.roles[:admin], User.roles[:agent]]
      end

      if params[:query].strip.present?
        columns += " AND (users.name ILIKE ('%' || ? || '%') OR users.username ILIKE ('%' || ? || '%')) "
        values += [params[:query], params[:query]]
      end
      query =  columns.present? ? [columns, *values] : []
      { query: query, joins: joins, filter: filter }
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
