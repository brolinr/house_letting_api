class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :destroy]

  # GET /feedbacks
  def index
    @feedbacks = Feedback.all

    render json: @feedbacks, only: :description
  end

  # GET /feedbacks/1
  def show
    render json: @feedback, only: :description
  end

  # POST /feedbacks
  def create
    @feedback = Feedback.new(feedback_params)
    @customer_id = Customer.find_by(phone: params[:phone]).id
    @feedback.customer_id = @customer_id
    if @feedback.save
      render json: @feedback, status: :created, location: @feedback, only: :description
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feedback_params
      params.require(:feedback).permit(:description)
    end
end
