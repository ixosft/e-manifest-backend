module V1
  class UsersController < ApplicationController
    def index
      index_params = user_params.index
      query = index_params[:query]
      filter = index_params[:filter]
      include = index_params[:include]
      @users = User.includes(include).where(query).before(with_cursor).where(filter).limit(per_page)
      render json: V1::UserSerializer.new(@users, user_options.index(@users)).serializable_hash
    end

    def update
      update_params = user_params.update
      @user = User.find(params[:id])
      @user.update!(update_params[:attrs])
      render json: V1::UserSerializer.new(@user, user_options.update).serializable_hash
    end

    def validate_username
      validate_username_params = user_params.validate_username
      render json: { valid: !User.exists?(validate_username_params[:query]) }
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
