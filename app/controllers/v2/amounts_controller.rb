# frozen_string_literal: true

class V2::AmountsController < ApplicationController
  def create
    render_not_found unless admin.instance_of?(Admin)

    @amount = admin.amounts.build(permitted_params)
    if @amount.save
      render json: @amount, status: :created
    else
      render_unprocessable(@amount)
    end
  rescue StandardError => e
    return if response.body.include?('error')

    render_internal_error(e)
  end

  def index
    @amounts = Amount.all.pluck(:price, :created_at)

    if @amounts.any?
      render json: { amounts: @amounts }, status: :ok
    else
      render json: { error: 'Amounts empty! Create some.' }, status: :no_content
    end
  rescue StandardError => e
    return if response.body.include?('error')

    render_internal_error(e)
  end

  private

  def permitted_params
    params.require(:amount).permit(:price)
  end

  def admin
    @admin = Admin.find_by(phone: params[:admin_phone])
  end
end
