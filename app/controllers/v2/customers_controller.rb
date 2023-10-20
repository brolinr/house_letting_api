class V2::CustomersController < ApplicationController
  def create
    begin
      @customer = Customer.new(permitted_params)

      if @customer.save
        render json: @customer, status: :created
      else
        render_unprocessable(@customer)
      end
    rescue StandardError => e
      render_internal_error(e)
    end
  end

  def update
    render_not_found unless admin.instance_of?(Customer)

    begin
      if admin.update(permitted_params)
        render json: admin.reload, status: :ok
      else
        render_unprocessable(admin)
      end
    rescue StandardError => e
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
      render_internal_error(e)
    end
  end

  private

  def permitted_params
    params.require(:customer).permit(:name, :phone)
  end

  def customer
    @customer ||= Customer.find_by(phone: permitted_params[:phone])
  end
end