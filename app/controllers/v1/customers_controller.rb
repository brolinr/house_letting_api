# frozen_string_literal: true

class V1::CustomersController < ApplicationController
  # Create customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer, status: :created, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:customer).permit(:name, :phone)
  end
end
