class ApplicationController < ActionController::API
  include ::ActionController::Cookies
  include ExceptionHandler

  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(cookies.signed[:jwt]).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
