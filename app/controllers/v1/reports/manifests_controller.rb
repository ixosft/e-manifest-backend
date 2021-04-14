# frozen_string_literal: true

module V1
  module Reports
    class ManifestsController < ApplicationController
      def index
        index_params = manifest_params.index
        query = index_params[:query]
        @manifests = ::Manifest.find_by_sql(query)
        render json: V1::ManifestPersonSerializer.new(@manifests, manifest_options.index(@manifests)).serializable_hash
      end

      private

      def manifest_params
        @manifest_params ||= V1::Reports::ManifestParams.new(params)
      end

      def manifest_options
        @manifest_options ||= V1::Reports::ManifestOptions.new(params)
      end
    end
  end
end
