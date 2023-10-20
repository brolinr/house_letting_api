# frozen_string_literal: true

class V1::SubscriptionsController < ApplicationController
  # Show all subscriptions
  def index
    @subscriptions = Subscription.all
    render json: @subscriptions
  end

  # Create a subscription
  def create
    @subscription = Subscription.new(subscription_params)
    @customer = Customer.find_by(phone: @subscription.phone)

    if @customer.subscriptions.none? || @customer.subscriptions.last.created_at + 30.days < Time.zone.now
      @subscription.customer_id = @customer.id
      process_payment
      sleep 16

      @poll_url = PaynowStatus.check_transaction_status(@subscription.poll_url)
      if @poll_url['status'] == 'Paid' && @subscription.save
        render json: 'Congratulations your subscription has been paid.', status: :created, location: @subscription
      else
        render json: 'Sorry your subscription failed please resend your mobile number.', status: :unprocessable_entity
      end
    else
      sub_end_date = @customer.subscriptions.last.created_at + 30.days
      render json: "Your subscription is expiring on #{sub_end_date.to_formatted_s(:long)}."
    end
  end

  # Ecocash payment processing
  def process_payment
    amount = User.first.amounts.last
    @subscription.month = Date::MONTHNAMES[Time.zone.now.mon]
    paynow = Paynow.new(INTEGRATION_ID, INTEGRATION_KEY,
                        'https://api-bluffhope.herokuapp.com/', 'https://api-bluffhope.herokuapp.com/')
    payment = paynow.create_payment('Company Subscription', 'rutendomazwi@gmail.com')
    payment.add("#{Date::MONTHNAMES[Time.zone.now.mon]} Subscription", amount.price)
    response = paynow.send_mobile(payment, @subscription.ecocash_number, 'ecocash')

    # Get the poll url (used to check the status of a transaction) and save in DB.
    if response.success
      poll_url = response.poll_url
      poll_url = PaynowStatus.check_transaction_status(poll_url)
      @subscription.poll_url = poll_url['pollurl']
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def subscription_params
    params.require(:subscription).permit(:poll_url, :month, :ecocash_number, :customer_id, :phone)
  end
end
