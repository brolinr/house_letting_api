class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :update, :destroy]

  # Listing all properties
  def index
    @properties = Property.all
      render json: @properties, only: [:id, :city, :description]
  end

  # Showing a requested property
  def show
    #if customer has any subscriptions && if the customer's last subscription has not expired
      #render json: @property, only: [:city, :description, :address, :image]
      render json: @property, only: [:city, :description, :address, :contact]
    #else
      #index the properties
    #end
  end

  # Create a property
  def create
    #authenticate user && confirm if the user is an admin
    @property = Property.new(property_params)
    #@property = current_user.properties.build(property_params)
    if @property.save
      #render json: @property.as_json(only: %i[city description address contact city]).merge(
       # image_path: url_for(@property.image))
      render json: @property, status: :created, location: @property, except: [:created_at, :updated_at]
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  # Update a property
  def update
    if @property.update(property_params)
      render json: @property, except: [:created_at, :updated_at]
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  # Delete a cityd property
  def destroy
    #authenticate user && confirm if the user is an admin
    @property.destroy
  end
  
  private
    def set_property
      @property = Property.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:city, :description, :address, :contact, :user_id)
    end
end
