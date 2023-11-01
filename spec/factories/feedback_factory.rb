# frozen_string_literal: true

FactoryBot.define do
  factory(:feedback) do
    description { FFaker::LoremFR.paragraph }
    feedback_type { rand(4) }

    customer

    trait(:with_customer) do
      customer { create(:customer) }
    end
  end
end
