# frozen_string_literal: true

module V1
  class TerminalsController < ApplicationController
    def index
      index_params = terminal_params.index
      query = index_params[:query]
      include = index_params[:include]
      filter = index_params[:filter]
      joins = index_params[:joins]
      @terminals = Terminal.joins(joins).includes(include).where(query).where(filter).before(with_cursor).limit(per_page)
      render json: V1::TerminalSerializer.new(@terminals, terminal_options.index(@terminals)).serializable_hash
    end

    def create
      create_params = terminal_params.create
      @terminal = Terminal.new(create_params[:attrs])
      if @terminal.save!
        create_options = terminal_options.create
        render json: V1::TerminalSerializer.new(@terminal, create_options).serializable_hash
      else
        render json: @terminal.errors, status: :bad_request
      end
    end

    def update
      update_params = terminal_params.update
      @terminal = Terminal.find(params[:id])
      @terminal.update!(update_params[:attrs])
      render json: V1::TerminalSerializer.new(@terminal, terminal_options.update).serializable_hash
    end

    def destroy
      Terminal.find(params[:id]).discard
      head :no_content, status: :ok
    end

    private

    def terminal_params
      @terminal_params ||= V1::TerminalParams.new(params)
    end

    def terminal_options
      @terminal_options ||= V1::TerminalOptions.new(params)
    end
  end
end
