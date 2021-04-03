# frozen_string_literal: true

module V1
  class MotorsController < ApplicationController
    def index
      index_params = motor_params.index
      query = index_params[:query]
      include = index_params[:include]
      filter = index_params[:filter]
      @motors = Motor.includes(include).where(query).where(filter).before(with_cursor).limit(per_page)
      render json: V1::MotorSerializer.new(@motors, motor_options.index(@motors)).serializable_hash
    end

    def create
      create_params = motor_params.create
      @motor = Motor.new(create_params[:attrs])
      if @motor.save!
        create_options = motor_options.create
        render json: V1::MotorSerializer.new(@motor, create_options).serializable_hash
      else
        render json: @motor.errors, status: :bad_request
      end
    end

    def update
      update_params = motor_params.update
      @motor = Motor.find(params[:id])
      @motor.update!(update_params[:attrs])
      render json: V1::MotorSerializer.new(@motor, motor_options.update).serializable_hash
    end

    def destroy
      Motor.find(params[:id]).destroy!
      head :no_content, status: :ok
    end

    def validate_plate_number
      validate_number_plate_params = motor_params.validate_number_plate
      render json: { valid: !User.exists?(validate_number_plate_params[:query]) }
    end

    private

    def motor_params
      @motor_params ||= V1::MotorParams.new(params)
    end

    def motor_options
      @motor_options ||= V1::MotorOptions.new(params)
    end
  end
end
