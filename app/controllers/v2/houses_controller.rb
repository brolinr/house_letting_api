# frozen_string_literal: true

class V2::HousesController < ApplicationController
  before_action :admin
  before_action :house, except: :create

  def create
    @house = admin.properties.build(permitted_params)
    if @house.save
      render json: @house, status: :created
    else
      render_unprocessable(@house)
    end
  rescue StandardError => e
    render_internal_error(e)
  end

  def update
    if house.update(permitted_params)
      render json: house.reload, status: :ok
    else
      render_unprocessable(house)
    end
  rescue StandardError => e
    render_internal_error(e)
  end

  def destroy
    if house.destroy
      render json: { success: 'House deleted' }, status: :no_content
    else
      render_unprocessable(house)
    end
  rescue StandardError => e
    render_internal_error(e)
  end

  def show
    render json: house, status: :found
  rescue StandardError => e
    render_internal_error(e)
  end

  def index
    @houses = Houses.all.pluck(:description)

    if @houses.any?
      render json: { amounts: @houses }, status: :ok
    else
      render json: { message: 'Housess empty!' }, status: :no_content
    end
  rescue StandardError => e
    render_internal_error(e)
  end

  private

  def permitted_params
    params.require(:house).permit(:description, :contact, :location,
                                  :owner_phone, :owner_email, :owner_whatsapp)
  end

  def house
    @house ||= Property.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def admin
    @admin ||= Admin.find_by(phone: params[:admin_phone])
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end
end
