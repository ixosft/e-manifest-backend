module V1
  class CompaniesController < ApplicationController
    def index
      index_params = company_params.index
      query = index_params[:query]
      include = index_params[:include]
      filter = index_params[:filter]
      @companies = Company.includes(include).where(query).where(filter).before(with_cursor).limit(per_page)
      render json: V1::CompanySerializer.new(@companies, company_options.index(@companies)).serializable_hash
    end

    def create
      create_params = company_params.create
      @company = Company.new(create_params[:attrs])
      if @company.save!
        create_options = company_options.create
        render json: V1::CompanySerializer.new(@company, create_options).serializable_hash
      else
        render json: @company.errors, status: :bad_request
      end
    end

    def update
      update_params = company_params.update
      @company = Company.find(params[:id])
      @company.update!(update_params[:attrs])
      render json: V1::CompanySerializer.new(@company, company_options.update).serializable_hash
    end

    def destroy
      Company.find(params[:id]).discard
      head :no_content, status: :ok
    end

    private

    def company_params
      @company_params ||= V1::CompanyParams.new(params)
    end

    def company_options
      @company_options ||= V1::CompanyOptions.new(params)
    end
  end
end
