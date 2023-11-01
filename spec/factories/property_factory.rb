# frozen_string_literal: true

FactoryBot.define do
  factory(:property) do
    location { FFaker::Address.street_address }
    description { FFaker::Lorem.paragraph }
    owner_phone { FFaker::PhoneNumber.phone_number }
    owner_whatsapp { FFaker::PhoneNumber.phone_number }
    owner_email { FFaker::Internet.email }
    admin

    trait(:with_admin) do
      admin { create(:admin) }
    end
  end
end
