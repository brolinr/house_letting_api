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
    last_paid_subscription = @customer.subscriptions.last

    if @customer.subscriptions.empty? || last_paid_subscription.created_at + 30.days
      @subscription.customer_id = @customer.id
      process_paynow
  
      if @subscription.save
        render json: "#{@customer.name} #{@instructions}", status: :created, location: @subscription
      else
        render json: "Sorry#{@customer.name} your subscription failed please resend our mobile number",
              status: :unprocessable_entity
      end
    else
      render json: "Your subscription is expiring on #{sub_end_date.to_formatted_s(:long)}."
    end
  end

  #Ecocash payment processing
  def process_paynow
    amount = User.first.amounts.last
    @subscription.month = Date::MONTHNAMES[Time.now.mon]

    paynow = Paynow.new("13262", 
                        "490f62fb-a107-49fa-8a8d-691e741a06d9",
                        "http://localhost:3000/",
                        "http://localhost:3000/")

    payment = paynow.create_payment("Company Subscription", 
                                    "rutendomazwi@gmail.com")
    payment.add("#{Date::MONTHNAMES[Time.now.mon]} Subscription", amount.price)

    response = paynow.send_mobile(payment, @subscription.ecocash_number, 'ecocash')

    # Get the poll url (used to check the status of a transaction) and save in DB.
    if response.success
      poll_url = response.poll_url
      @subscription.poll_url = poll_url
      @instructions = response["instruction"]
    end
  end

  def check_status
    # Check the status of the transaction with the specified poll url
    status = PaynowStatus.check_transaction_status(@subscription.poll_url)
    if status["status"] == "Paid"
      "Payment successfull"
    else
      "Not Paid"
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
