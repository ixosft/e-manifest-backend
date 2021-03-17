# frozen_string_literal: true

module V1
  class SessionsController < ApplicationController
    skip_before_action :authenticate_request, only: %i[login register]
    # TODO: admin only route
    def register
      @user = User.create(user_params.create[:attrs])
      if @user.save
        response = { message: 'User created successfully' }
        render json: response, status: :created
      else
        render json: @user.errors, status: :bad_request
      end
    end

    def login
      authenticate params[:email], params[:password]
    end

    private

    def user_params
      @user_params ||= V1::UserParams.new(params)
    end

    def authenticate(email, password)
      command = AuthenticateUser.call(email, password)

      if command.success?
        # TODO: In order to keep the session active then, we need to reset this cookie, with a new expiration, every time we receive an authenticated requests.

        # Another option to address this issue is to give your encoded JWTs a short expiration date, re-issue them and re-set the cookie with each valid request.
        cookies.signed[:jwt] = { value: command.result, httponly: true, expires: 24.hour.from_now }
        render json: {
          user_hash: {},
          message: 'Login Successful'
        }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end
  end
end
