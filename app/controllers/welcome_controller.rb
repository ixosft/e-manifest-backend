class WelcomeController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index]
  def index
    render json: { message: 'yes' }
  end
end
