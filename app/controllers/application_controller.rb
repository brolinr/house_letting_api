# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_not_found
    render json: { error: 'Account not found' }, status: :not_found
  end

  def render_internal_error(error)
    render json: { error: error.message }, status: :internal_server_error
  end

  def render_unprocessable(object)
    render json: { errors: object.errors.full_messages }, status: :unprocessable_entity
  end
end
