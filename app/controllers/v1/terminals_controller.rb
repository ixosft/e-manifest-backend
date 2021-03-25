# frozen_string_literal: true

module V1
  class TerminalsController < ApplicationController
    def index
      index_params = terminal_params.index
      query = index_params[:query]
      @terminals = Terminal.where(query).before(with_cursor).limit(per_page)
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

    private

    def terminal_params
      @terminal_params ||= V1::TerminalParams.new(params)
    end

    def terminal_options
      @terminal_options ||= V1::TerminalOptions.new(params)
    end
  end
end
