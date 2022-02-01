class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :update, :destroy]

  # GET /properties
  def index
    @properties = Property.all
    render json: @properties
  end

  # GET /properties/1
  def show
    #if user.subscribed then
      #render json: @property, only: [:name, :description, :address, :image]
      render json: @property, only: [:name, :description, :address, :contact]
    #else
      #index
    #end
  end

  # POST /properties
  def create
    #authenticate user && confirm if the user is an admin
    @property = Property.new(property_params)

    if @property.save
      #render json: @property.as_json(only: %i[name description address contact name]).merge(
       # image_path: url_for(@property.image))
      render json: @property, status: :created, location: @property, except: [:created_at, :updated_at]
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /properties/1
  def update
    #authenticate user && confirm if the user is an admin
    if @property.update(property_params)
      render json: @property, except: [:created_at, :updated_at]
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  # DELETE /properties/1
  def destroy
     #authenticate user && confirm if the user is an admin
    @property.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:name, :description, :address, :contact, :image)
    end
end
