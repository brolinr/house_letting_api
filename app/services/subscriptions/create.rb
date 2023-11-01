# frozen_string_literal: true

class Subscriptions::Create < ApplicationService
  attr_reader :result

  def call
    preload(subscription, customer)
    initialize_payment
    handle_subscription_creation
    { message: @result, subscription: subscription }
  end

  private

  def subscription
    @subscription ||= customer.reload.subscriptions.new(params)
  end

  def customer
    @customer ||= context[:customer]
  end

  def initialize_payment
    subscription_fee = Amount.last.price
    subscription_month = Date::MONTHNAMES[Time.zone.now.mon]

    subscription.month = subscription_month
    subscription.fee = subscription_fee

    paynow = Paynow.new(
      ENV.fetch('PAYNOW_INTEGRATION_ID', nil),
      ENV.fetch('PAYNOW_INTEGRATION_KEY', nil),
      ENV.fetch('PAYMENT_RETURN_URL', nil),
      ENV.fetch('PAYMENT_RESULT_URL', nil)
    )

    payment = paynow.create_payment('Subscription fee', ENV.fetch('PAYNOW_AUTH_EMAIL', nil))
    payment.add("#{subscription_month} subscription", subscription_fee)

    payment_response = paynow.send_mobile(payment, permitted_params[:ecocash_number], 'ecocash')
    if payment_response.success
      poll_url = payment_response.poll_url
      poll_url = PaynowStatus.check_transaction_status(poll_url)
      poll_url = poll_url['pollurl']
    end

    subscription.poll_url = poll_url
    subscription.payment_status = :pending
  end

  def payment_status
    @payment_status = PaynowStatus.check_transaction_status(subscription.poll_url)
    sleep 10
    @payment_status[:status]
  end

  def handle_subscription_creation
    case payment_status
    when 'Error', 'NotFound'
      subscription.payment_status = :error
      @result = 'There was an error processing your payment.'
    when 'Paid'
      subscription.payment_status = :paid
      @result = 'Your payment was successful.'
    when 'Created', 'Sent'
      subscription.payment_status = :pending
      @result = 'Your payment is awaiting confirmation.'
    when 'Cancelled'
      subscription.payment_status = :cancelled
      @result = 'Your payment was cancelled. Restart the subscription process.'
    when 'Disputed'
      subscription.payment_status = :pending
      @result = 'Transaction has been disputed and funds are being held in suspense until
                 the dispute has been resolved.'
    when 'Refunded'
      subscription.payment_status = :refunded
      @result = 'You were refunded.'
    end
    subscription.save
  end
end
