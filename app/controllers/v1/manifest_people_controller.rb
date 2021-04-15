module V1
  class ManifestPeopleController < ApplicationController
    def index
      index_params = manifest_people_params.index
      query = index_params[:query]
      filter = index_params[:filter]
      include = index_params[:include]
      joins = index_params[:joins]
      @manifest_people = ManifestPerson.joins(joins).includes(include).where(query).where(filter).before(with_cursor).limit(per_page)
      render json: V1::ManifestPersonSerializer.new(@manifest_people, manifest_people_options.index(@manifest_people)).serializable_hash
    end

    def destroy
      ManifestPerson.find(params[:id]).destroy
      head :no_content, status: :ok
    end

    private

    def manifest_people_params
      @manifest_people_params ||= V1::ManifestPeopleParams.new(params)
    end

    def manifest_people_options
      @manifest_people_options ||= V1::ManifestPeopleOptions.new(params)
    end
  end
end
