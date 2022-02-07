class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :update, :destroy]

  # Show all subscriptions
  def index
    @subscriptions = Subscription.all
    #@subscriptions = current_customer.subscriptions.all
    render json: @subscriptions
  end

  # Create a subscription
  def create
    @subscription = Subscription.new(subscription_params)
    @customer = Customer.find_by(phone: @subscription.phone)
    @subscription.customer_id = @customer.id
    process_paynow
    if @subscription.save
      render json: "#{@customer.name} You have successifully paid your subscription.",
             status: :created, location: @subscription
    else
      render json: "Sorry#{@customer.name} your subscription failed please restart the process",
             status: :unprocessable_entity
    end
  end

  #Ecocash payment processing
  def process_paynow
    paynow = Paynow.new(ENV["INTEGRATION_ID"], ENV["INTEGRATION_KEY"],
                        "https://api-bluffhope.herokuapp.com/",
                        "https://api-bluffhope.herokuapp.com/")

    payment = paynow.create_payment("Company Subscription", 
                                    "subscription@email.com")
    amount = User.first.amounts.last
    payment.add("#{Date::MONTHNAMES[Time.now.mon]} Subscription", amount.price)
    @subscription.month = Date::MONTHNAMES[Time.now.mon]
    response = paynow.send_mobile(payment, @subscription.ecocash_number.to_s, 'ecocash')

    if response.success
      # Get the poll url (used to check the status of a transaction). You might want to save this in your DB
      poll_url = response.poll_url
      @subscription.poll_url = poll_url
      instructions = response.instructions
    end
  end

  private
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.require(:subscription).permit(:poll_url, :month, :ecocash_number, :customer_id, :phone)
    end
end
