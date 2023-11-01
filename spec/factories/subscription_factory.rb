# frozen_string_literal: true

FactoryBot.define do
  paynow_ecocash_test_numbers = ['0771111111', '0772222222', 0o773333333, 0o774444444]

  factory(:subscription) do
    poll_url { FFaker::Internet.http_url }
    month { FFaker::Time.month }
    ecocash_number { paynow_ecocash_test_numbers.sample }
    payment_status { rand(4) }
    fee { rand(8989) }

    customer

    trait(:with_customer) do
      customer { create(:customer) }
    end
  end
end
