class V2::SubscriptionsController < ApplicationController
  def create
    render_not_found if customer.instance_of?(Customer)

    if customer.subscriptions.any? && customer.subscribed?
      render json: { message: 'You are already subscribed!' }, status: :ok
    else
      result = Subscriptions::Create.call(params: permitted_params, context: { customer: customer })
      begin
        if result[:subscription].payment_status == :paid
          render json: { message: result[:message] }, status: :ok
        else
          render json: { error: result[:message] }, status: :failed
        end
      end
    end
  rescue StandardError => e
    render_internal_error(e)
  end

  private
  def permitted_params
    params.require(:subscription).permit(:ecocash_number)
  end

  def customer
    @customer ||= Customer.find_by(phone: params[:phone])
  end
end