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
    paynow = Paynow.new("13223", "825053af-5388-4789-b24a-ac6105c80a05",
                        "https://api-bluffhope.herokuapp.com/",
                        "https://api-bluffhope.herokuapp.com/")
    payment = paynow.create_payment("Company Subscription", 
                                    "subscription@email.com")
    amount = User.first.amounts.last
    payment.add("#{Date::MONTHNAMES[Time.now.mon]} Subscription", amount.price)
    @subscription.month = Date::MONTHNAMES[Time.now.mon]
    response = paynow.send_mobile(payment, @subscription.ecocash_number, 'ecocash')
    # Get the poll url (used to check the status of a transaction) and save in DB.
    if response.success
      poll_url = response.poll_url
      @subscription.poll_url = poll_url
      instructions = response.instructions
    end
    # Check the status of the transaction with the specified poll url
    status = PaynowStatus.check_transcation_status(poll_url)
    if status["status"] == "Paid"
      render page
      print "Payment successfull"
    else
      print "Not Paid"
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
