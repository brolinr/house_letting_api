# frozen_string_literal: true

class V2::FeedbacksController < ApplicationController
  def create
    @feedback = customer.feedbacks.build(permitted_params)

    if @feedback.save
      render json: @feedback, status: :created
    else
      render_unprocessable(@feedback)
    end
  rescue StandardError => e
    render_internal_error(e)
  end

  def index
    @feedbacks = Feedback.all.pluck(:description)

    if @feedbacks.any?
      render json: { amounts: @feedbacks }, status: :ok
    else
      render json: { message: 'Feedbacks empty! Encourage customers to review more.' }, status: :no_content
    end
  rescue StandardError => e
    render_internal_error(e)
  end

  def show
    render_not_found unless feedback.instance_of?(Feedback)
    render json: feedback, status: :found
  rescue StandardError => e
    render_internal_error(e)
  end

  private

  def permitted_params
    params.require(:feedback).permit(:description, :reporter)
  end

  def feedback
    @feedback ||= Feedback.find_by(description: permitted_params[:description])
  end

  def customer
    @customer ||= Customer.find_by(phone: params[:phone])
  end
end
