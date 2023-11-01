# frozen_string_literal: true

class V2::CustomersController < ApplicationController
  def create
    @customer = Customer.new(permitted_params)

    if @customer.save
      render json: @customer, status: :created
    else
      render_unprocessable(@customer)
    end
  rescue StandardError => e
    return if response.body.include?('error')

    render_internal_error(e)
  end

  def update
    render_not_found unless customer.instance_of?(Customer)

    begin
      if customer.update(permitted_params)
        render json: customer.reload, status: :ok
      else
        render_unprocessable(customer)
      end
    rescue StandardError => e
      return if response.body.include?('error')

      render_internal_error(e)
    end
  end

  def destroy
    render_not_found unless customer.instance_of?(Customer)

    begin
      if customer.destroy
        render json: { success: 'Account deleted' }, status: :no_content
      else
        render_unprocessable(customer)
      end
    rescue StandardError => e
      return if response.body.include?('error')

      render_internal_error(e)
    end
  end

  private

  def permitted_params
    params.require(:customer).permit(:name, :phone)
  end

  def customer
    @customer ||= Customer.find_by(phone: params[:phone])
  end
end
