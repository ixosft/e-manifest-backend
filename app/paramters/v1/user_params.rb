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
      columns = ''
      include = []

      # TODO: add index to role, role and name, role and username, username, name
      if params[:type] == 'for_user_dropdown'
        columns += ' users.role in (?) '
        values << [User.roles[:admin], User.roles[:agent]]
      else
        include << :terminal
      end

      if params[:query].present? && params[:query].strip.presence
        columns += "  #{columns.present? ? ' AND ' : ' '} (users.name ILIKE ('%' || ? || '%') OR users.username ILIKE ('%' || ? || '%')) "
        values += [params[:query], params[:query]]
      end

      filter_values, filter = ::V1::FilterService.new(params).build_query_params
      query =  columns.present? ? [columns, *values] : []
      filter = filter.strip.present? ? [filter, *filter_values] : []
      { query: query, joins: joins, filter: filter, include: include }
    end

    def create
      { attrs: user_params }
    end

    def update
      { attrs: user_params }
    end

    def validate_username
      columns = 'username = ?'
      values = [params[:username]]
      if params[:id]
        columns += ' and id != ?'
        values << params[:id]
      end
      { query: [columns, *values] }
    end

    private

    def user_params
      @user_params ||= params.permit(
        :name, :username, :terminal_id, :number, :email, :password, :active, :role
      )
    end
  end
end
