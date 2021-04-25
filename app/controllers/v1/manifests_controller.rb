# frozen_string_literal: true

module V1
  class ManifestsController < ApplicationController
    def index
      index_params = manifest_params.index
      query = index_params[:query]
      include = index_params[:include]
      filter = index_params[:filter]
      joins = index_params[:joins]
      @manifests = Manifest.joins(joins).includes(include).where(query).where(filter).before(with_cursor).limit(per_page)
      render json: V1::ManifestSerializer.new(@manifests, manifest_options.index(@manifests)).serializable_hash
    end

    def show
      index_params = manifest_params.index
      include = index_params[:include]
      @manifest = Manifest.includes(include).find(params[:id])
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
      index_params = manifest_params.index
      update_params = manifest_params.update
      include = index_params[:include]
      @manifest = Manifest.includes(include).find(params[:id])
      ActiveRecord::Base.transaction do
        @manifest.update!(update_params[:attrs])
      end
      render json: V1::ManifestSerializer.new(@manifest, manifest_options.update).serializable_hash
    end

    def destroy
      Manifest.find(params[:id]).discard
      head :no_content, status: :ok
    end

    def download_manifest
      index_params = manifest_params.index
      include = index_params[:include]
      manifest = Manifest.includes(include).find(params[:id])
      pdf_html = ActionController::Base.new.render_to_string(
        template: 'manifests/manifest.html.erb',
        layout: 'pdf',
        formats: :html,
        encoding: 'UTF-8',
        locals: { manifest: manifest }
      )
      pdf = WickedPdf.new.pdf_from_string(pdf_html, { orientation: 'Landscape' })
      send_data pdf, filename: 'manifest.pdf', disposition: 'attachment', type: 'application/pdf'
    end

    private

    def get_html
      ActionController::Base
    end

    def manifest_params
      @manifest_params ||= V1::ManifestParams.new(params)
    end

    def manifest_options
      @manifest_options ||= V1::ManifestOptions.new(params)
    end
  end
end
