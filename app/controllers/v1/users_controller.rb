module V1
  class UsersController < ApplicationController
    def index
      index_params = user_params.index
      query = index_params[:query]
      @users = User.where(query).before(with_cursor).limit(per_page)
      render json: V1::UserSerializer.new(@users, user_options.index(@users)).serializable_hash
    end

    private

    def user_params
      @user_params ||= V1::UserParams.new(params)
    end

    def user_options
      @user_options ||= V1::UserOptions.new(params)
    end
  end
end
