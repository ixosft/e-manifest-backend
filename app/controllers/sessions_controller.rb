# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login logout register]
  # TODO: admin only route
  def register
    raise ExceptionHandler::AuthenticationError if params[:role].to_s == '4' # can't create user with super admin role

    @user = User.create(user_params.create[:attrs])
    if @user.save!
      render json: register_response, status: :created
    else
      render json: @user.errors, status: :bad_request
    end
  end

  def login
    authenticate params[:username], params[:password]
  end

  def logout
    # cookies.delete(:jwt, domain: :all)
    response.set_cookie(
      :jwt,
      { path: '/', value: '', httponly: true, secure: Rails.env.production?, expires: Time.at(0) }.merge!(
        Rails.env.production? ? { same_site: 'None' } : {}
      )
    )
    head :no_content, status: :ok
  end

  def user
    render json: V1::UserSerializer.new(current_user, user_options.auth).serializable_hash
  end

  private

  def user_params
    @user_params ||= V1::UserParams.new(params)
  end

  def user_options
    @user_options ||= V1::UserOptions.new(params)
  end

  def register_response
    params[:type] == 'for_auth' ? { message: 'User created successfully' } : V1::UserSerializer.new(@user, user_options.register).serializable_hash
  end

  def authenticate(username, password)
    command = AuthenticateUser.call(username, password)
    if command.success?
      # TODO: In order to keep the session active then, we need to reset this cookie, with a new expiration, every time we receive an authenticated requests.

      # Another option to address this issue is to give your encoded JWTs a short expiration date, re-issue them and re-set the cookie with each valid request.
      # https://breakdev.org/sniping-insecure-cookies-with-xss/
      # https://www.skcript.com/svr/samesite-issue-with-rails-in-chrome/
      result = command.result
      response.set_cookie(
        :jwt,
        {
          path: '/',
          httponly: true,
          value: result[:token],
          expires: 24.hour.from_now,
          secure: Rails.env.production?
        }.merge!(Rails.env.production? ? { same_site: 'None', domain: ['.netlify.app', '.herokuapp.com'] } : {})
      )
      render json: V1::UserSerializer.new(result[:user], user_options.auth).serializable_hash
    else
      render json: { error: command.errors }, status: :bad_request
    end
  end
end
