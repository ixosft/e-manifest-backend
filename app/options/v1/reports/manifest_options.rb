module V1
  module Reports
    class ManifestOptions
      attr_reader :params
      DEFAULT = {
        fields: {
          manifest_person: %i[id
                              total_trip_to
                              people_count
                              total_motors
                              total_terminal
                              total_people
                              total_companies
                              destination_state
                              total_users]
        }
      }.freeze

      def initialize(params)
        @params = params
      end

      def index(_manifests)
        DEFAULT
      end
    end
  end
end
