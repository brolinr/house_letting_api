class AmountsController < ApplicationController
  before_action :set_amount, only: [:show, :update, :destroy]

  # Display the list of all amount
  def index
    @amounts = Amount.all
    render json: @amounts
  end

  # show an amount
  def show
    render json: @amount
  end

  # Create an amount
  def create
    @amount = Amount.new(amount_params)
    @amount.user_id = User.first.id
    if @amount.save
      render json: @amount, status: :created, location: @amount
    else
      render json: @amount.errors, status: :unprocessable_entity
    end
  end

  private
    def set_amount
      @amount = Amount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def amount_params
      params.require(:amount).permit(:price)
    end
end
