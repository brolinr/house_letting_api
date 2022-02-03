class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :update, :destroy]

  # GET /subscriptions
  def index
    @subscriptions = Subscription.all
    @subscriptions = current_customer.subscriptions.all

    render json: @subscriptions
  end

  # GET /subscriptions/1
  def show
    render json: @subscription
  end

  # POST /subscriptions
  def create
    
    @subscription = Subscription.new(subscription_params)
    proccess_paynow
    if @subscription.save
      render json: @subscription, status: :created, location: @subscription
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end



  #Ecocash payment processing
  def proccess_paynow
    paynow = Paynow.new(ENV["INTEGRATION_ID"], ENV["INTEGRATION_KEY"],
                        "https://doucetech.herokuapp.com/",
                        "https://doucetech.herokuapp.com/")

    payment = paynow.create_payment("Company Subscription", 
                                    @subscription.email)

    payment.add("#{Date::MONTHNAMES[Time.now.mon]} Subscription", Amount.last)

    response = paynow.send_mobile(payment, @subscription.ecocash_number.to_s, 'ecocash')

    if response.success
      # Get the poll url (used to check the status of a transaction). You might want to save this in your DB
      poll_url = response.poll_url
      instructions = response.instructions
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.require(:subscription).permit(:poll_url, :month, :ecocash_number)
    end
end
