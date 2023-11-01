# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :handle_double_render

  def unauthorized_action
    render json: { failure: 'You are not authorized to visit the location' }, status: :unauthorized
  end

  def render_not_found
    render json: { error: 'Record does not exist' }, status: :not_found
  end

  def render_internal_error(error)
    error.message.join(',') if error.instance_of?(Array)

    render json: { error: error.message }, status: :internal_server_error
  end

  def render_unprocessable(object)
    render json: { errors: object.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def handle_double_render
    return if response.present?
  end
end
