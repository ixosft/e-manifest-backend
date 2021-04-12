# frozen_string_literal: true

module V1
  class ManifestsController < ApplicationController
    def index
      index_params = manifest_params.index
      query = index_params[:query]
      include = index_params[:include]
      filter = index_params[:filter]
      @manifests = Manifest.includes(include).where(query).where(filter).before(with_cursor).limit(per_page)
      render json: V1::ManifestSerializer.new(@manifests, manifest_options.index(@manifests)).serializable_hash
    end

    def show
      @manifest = Manifest.find(params[:id])
      render json: V1::ManifestSerializer.new(@manifest, manifest_options.show).serializable_hash
    end

    def create
      create_params = manifest_params.create
      @manifest = Manifest.new(create_params[:attrs])
      ActiveRecord::Base.transaction do
        @manifest.save!
      end
      create_options = manifest_options.create
      render json: V1::ManifestSerializer.new(@manifest, create_options).serializable_hash
    end

    def update
      update_params = manifest_params.update
      @manifest = Manifest.find(params[:id])
      ActiveRecord::Base.transaction do
        @manifest.update!(update_params[:attrs])
      end
      render json: V1::ManifestSerializer.new(@manifest, manifest_options.update).serializable_hash
    end

    def destroy
      Manifest.find(params[:id]).discard
      head :no_content, status: :ok
    end

    private

    def manifest_params
      @manifest_params ||= V1::ManifestParams.new(params)
    end

    def manifest_options
      @manifest_options ||= V1::ManifestOptions.new(params)
    end
  end
end
