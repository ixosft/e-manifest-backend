module V1
  class TicketsController < ApplicationController
    def create_ticket
      create_params = manifest_people_params.create_ticket
      @ticket = ManifestPerson.new(create_params[:attrs])
      if @ticket.save!
        create_options = manifest_people_options.create_ticket
        render json: V1::ManifestPersonSerializer.new(@ticket, create_options).serializable_hash
      else
        render json: @ticket.errors, status: :bad_request
      end
    end

    def update_ticket
      update_params = manifest_people_params.update_ticket
      @ticket = ManifestPerson.find(params[:manifest_person_id])
      @ticket.update!(update_params[:attrs])
      render json: V1::ManifestPersonSerializer.new(@ticket, manifest_people_options.update_ticket).serializable_hash
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
