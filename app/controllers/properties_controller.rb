class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :update, :destroy]

  # Listing all properties
  def index
    @properties = Property.all
    render json: @properties, only: [:id, :description]
  end

  # Showing a requested property
  def show
    @customer = Customer.find_by(phone: params[:phone])
    if @customer.subscriptions.last.created_at + 30.days > Time.now
      render json: @property, only: [:description, :contact]
    end
  end

  # Create a property
  def create
    @number = params[:phone]
    @property = Property.new(property_params)

    if @number == User.first.phone && @property.save
      render json: @property, status: :created, location: @property, except: [:created_at, :updated_at]
    else
      render json: "Sorry I cannot process your entry please send again"
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

  def destroy
    @property.destroy
  end
  
  private
    def set_property
      @property = Property.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:description, :contact, :user_id)
    end
end
