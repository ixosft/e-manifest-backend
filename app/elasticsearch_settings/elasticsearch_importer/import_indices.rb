module ElasticsearchImporter
  class ImportIndices
    IGNORE_MODELS = [].freeze
    def self.import
      Zeitwerk::Loader.eager_load_all if Rails.env.development?
      # No database connection error in rails console
      # next line establishes a connection.
      ActiveRecord::Base.connection
      ApplicationRecord.descendants.collect(&:name).each do |model_to_search|
        model = model_to_search.constantize

        next unless model.respond_to?(:mappings) && model.mappings.to_hash[:properties].present?

        begin
          model.__elasticsearch__.delete_index!
        rescue StandardError
          nil
        end

        model.__elasticsearch__.create_index!
        model.find_in_batches do |records|
          records.each(&:touch)
        end
      end
    end
  end
end
