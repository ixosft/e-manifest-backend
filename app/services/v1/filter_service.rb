module V1
  class FilterService
    attr_reader :params, :search, :filter, :resource_table
    def initialize(model, params)
      @params = params
      @resource_table = model.table_name
      @search = params[:search] || {}
      @filter = params[:filter] || {}
    end

    def build_query_params
      search_values, search_query = build_search_query
      filter_values, filter_joins, filter_columns = build_filter_query

      [(search_values + filter_values), (search_query + filter_columns), filter_joins]
    end

    def build_filter_query
      values = []
      joins = ''
      columns = ''
      join_cache = {}
      if filter.present?
        filter.each do |column_name, value|
          next unless value.present?

          values << value
          join_list = column_name.split('.')

          if join_list.size == 2
            columns += " #{columns.present? ? ' AND ' : ''} #{column_name} = ? "
            next
          end

          join_column, join_table, query_column = join_list
          unless join_cache[join_table]
            joins += " JOIN #{join_table} on #{resource_table}.#{join_column} = #{join_table}.id "
          end
          columns += " #{columns.present? ? ' AND ' : ''} #{join_table}.#{query_column} = ? "
          join_cache[join_table] = true
        end
      end

      [values, joins, columns]
    end

    def build_search_query
      search_params = [[], '']
      if search[:query].present? && search[:columns].present?
        columns = ''
        query = search[:query]
        values = []
        search[:columns].each_with_index do |column, i|
          columns += " #{i.positive? ? ' OR ' : ' '}  #{column} ILIKE ('%' || ? || '%')  "
          values << query
        end
        search_params = [values, columns]
      end
      search_params
    end
  end
end
Manifest.joins('JOIN motors on motors.id = manifests.motor_id JOIN terminals on terminals.id = manifests.terminal_id')
