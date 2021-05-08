module V1
  class FilterService
    attr_reader :params, :search, :filter, :resource_table
    # TODO, verify params
    def initialize(model, params)
      @params = params.to_unsafe_h
      @resource_table = model.table_name
      @search = @params[:search] || {}
      @filter = @params[:filter] || {}
      @joins = ''
      @join_cache = {}
    end

    def build_query_params
      search_values, search_query = build_search_query
      filter_values, filter_columns = build_filter_query

      [(search_values + filter_values), (search_query + (search_query.present? && filter_columns.present? ? ' AND ' : '') + filter_columns), @joins]
    end

    def build_filter_query
      values = []
      columns = ''
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
          build_joins(join_table, resource_table, join_column)
          columns += " #{columns.present? ? ' AND ' : ''} #{join_table}.#{query_column} = ? "
        end
      end

      [values, columns]
    end

    def build_special_query(type, table, col, values)
      if type == 'date'
        values << Date.parse('YYYY-MM-DD')
        " DATE(#{table}.#{col}) = DATE(?) "
      end
    end

    def build_joins(join_table, resource_table, join_column)
      unless @join_cache[join_table]
        @joins += " JOIN #{join_table} on #{resource_table}.#{join_column} = #{join_table}.id "
        @join_cache[join_table] = true
      end
    end

    def build_search_query
      search_params = [[], '']
      if search.keys.size.positive?
        column_string = ''
        values = []
        table = search.keys.first
        columns = search[table].keys
        columns.each_with_index do |column, i|
          query_data = search[table][column]
          join_data = search[table][:joins]
          next unless query_data[:value].present?

          build_joins(join_data[:table], table, join_data[:on]) if join_data.present?
          all_columns = query_data[:or].present? ? (query_data[:or] + [column]) : [column]
          all_columns_string = ''
          all_columns.each_with_index do |col, j|
            current_column_table = query_data[:table].presence || table
            query = if query_data[:type].present?
                      type = query_data[:type]
                      if type == 'date'
                        value = Date.parse(query_data[:value]).to_s
                        " #{current_column_table}.#{col}::date = '#{value}'::date "
                      elsif type == 'time'
                        value = Time.parse(query_data[:value]).to_s
                        " #{current_column_table}.#{col}::time = '#{value}'::time "
                      end
                    else
                      values << query_data[:value]
                      " #{current_column_table}.#{col} ILIKE ('%' || ? || '%')  "
                    end
            all_columns_string = " #{j.positive? ? ' OR ' : ' '}  #{query} "
          end
          column_string += " #{i.positive? ? ' AND ' : ' '}  ( #{all_columns_string} )  "
        end
        search_params = [values, column_string]
      end

      search_params
    end
  end
end
# Manifest.joins('JOIN motors on motors.id = manifests.motor_id JOIN terminals on terminals.id = manifests.terminal_id')
