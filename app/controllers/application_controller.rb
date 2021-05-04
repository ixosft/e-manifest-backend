class ApplicationController < ActionController::API
  include Pundit
  include ::ActionController::Cookies
  include ExceptionHandler

  before_action :authenticate_request
  attr_reader :current_user

  def per_page
    @per_page = if params[:per_page].present?
                  params[:per_page].to_s.downcase.strip == 'all' ? nil : params[:per_page].to_i
                else
                  PER_PAGE
                end
  end

  def with_cursor
    params[:cursor].to_i.zero? ? nil : params[:cursor].strip
  end

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.cookies['jwt']).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
