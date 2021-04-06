module V1
  module Reports
    class ManifestOptions
      attr_reader :params
      DEFAULT = {
        fields: {
          manifest_person: V1::ManifestPeopleSerializer::ATTRIBUTES
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
