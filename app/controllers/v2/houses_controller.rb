class V2::HousesController < ApplicationController
  def create
    render_not_found unless user.instance_of?(Admin)

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
    render_not_found unless house.instance_of?(Property)

    begin
      if house.update(permitted_params)
        render json: house.reload, status: :ok
      else
        render_unprocessable(house)
      end
    rescue StandardError => e
      render_internal_error(e)
    end
  end

  def destroy
    render_not_found unless house.instance_of?(Property)

    begin
      if house.destroy
        render json: { success: 'House deleted' }, status: :no_content
      else
        render_unprocessable(house)
      end
    rescue StandardError => e
      render_internal_error(e)
    end
  end

  def show
    render_not_found unless house.instance_of?(Property)
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
    params.require(:house).permit(:description, :contact)
  end

  def house
    @house ||= Property.find_by!(description: params[:description])
  end

  def admin
    @admin ||= Admin.find_by(phone: params[:phone])
  end
end