class AmountsController < ApplicationController
  before_action :set_amount, only: [:show, :update, :destroy]

  # GET /amounts
  def index
    @amounts = Amount.all

    render json: @amounts
  end

  # GET /amounts/1
  def show
    render json: @amount
  end

  # POST /amounts
  def create
    @amount = Amount.new(amount_params)

    if @amount.save
      render json: @amount, status: :created, location: @amount
    else
      render json: @amount.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /amounts/1
  def update
    if @amount.update(amount_params)
      render json: @amount
    else
      render json: @amount.errors, status: :unprocessable_entity
    end
  end

  # DELETE /amounts/1
  def destroy
    @amount.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amount
      @amount = Amount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def amount_params
      params.require(:amount).permit(:price, :user_id)
    end
end
