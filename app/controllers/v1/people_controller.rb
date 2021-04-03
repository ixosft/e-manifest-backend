module V1
  class PeopleController < ApplicationController
    def index
      index_params = person_params.index
      query = index_params[:query]
      include = index_params[:include]
      filter = index_params[:filter]
      @people = Person.includes(include).where(query).where(filter).before(with_cursor).limit(per_page)
      render json: V1::PersonSerializer.new(@people, person_options.index(@people)).serializable_hash
    end

    def create
      create_params = person_params.create
      @person = Person.new(create_params[:attrs])
      if @person.save!
        create_options = person_options.create
        render json: V1::PersonSerializer.new(@person, create_options).serializable_hash
      else
        render json: @person.errors, status: :bad_request
      end
    end

    def update
      update_params = person_params.update
      @person = Person.find(params[:id])
      @person.update!(update_params[:attrs])
      render json: V1::PersonSerializer.new(@person, person_options.update).serializable_hash
    end

    def destroy
      Person.find(params[:id]).destroy!
      head :no_content, status: :ok
    end

    private

    def person_params
      @person_params ||= V1::PersonParams.new(params)
    end

    def person_options
      @person_options ||= V1::PersonOptions.new(params)
    end
  end
end
