# frozen_string_literal: true

class V2::AdminsController < ApplicationController
  before_action :admin, except: :create

  def create
    @admin = Admin.new(permitted_params)

    if @admin.save
      render json: @admin, status: :created
    else
      render_unprocessable(@admin)
    end
  rescue StandardError => e
    return if response.body.include?('error')

    render_internal_error(e)
  end

  def update
    render_not_found unless admin.instance_of?(Admin)

    begin
      if admin.update(permitted_params)
        render json: admin.reload, status: :ok
      else
        render_unprocessable(admin)
      end
    rescue StandardError => e
      return if response.body.include?('error')

      render_internal_error(e)
    end
  end

  def destroy
    render_not_found unless admin.instance_of?(Admin)

    begin
      if admin.destroy
        render json: { success: 'Account deleted' }, status: :no_content
      else
        render_unprocessable(admin)
      end
    rescue StandardError => e
      return if response.body.include?('error')

      render_internal_error(e.join(','))
    end
  end

  private

  def permitted_params
    params.require(:admin).permit(:name, :phone)
  end

  def admin
    @admin ||= Admin.find_by(phone: params[:phone])
  end
end
