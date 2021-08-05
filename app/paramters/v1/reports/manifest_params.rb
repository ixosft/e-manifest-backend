module V1
  module Reports
    class ManifestParams
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def index
        joins = []
        values = []

        { query: dashboard_query }
      end

      private

      # TODO: clean up
      # create counters for major resources
      def dashboard_query
        "
          SELECT
          max(id) as id,
          destination_state,
          array_length(array_agg(DISTINCT manifest_id), 1) AS total_trip_to,
          array_length(array_agg(person_id), 1) AS people_count,
          (SELECT COUNT(*) FROM motors) as total_motors,
          (SELECT COUNT(*) FROM terminals) as total_terminal,
          (SELECT COUNT(*) FROM people) as total_people,
          (SELECT COUNT(*) FROM companies) as total_companies,
          (SELECT COUNT(*) FROM users) as total_users
        FROM
          manifest_people
        GROUP BY
          destination_state
        "
      end

      def manifest_params
        @manifest_params ||= params.permit
      end
    end
  end
end
