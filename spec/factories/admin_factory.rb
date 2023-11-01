# frozen_string_literal: true

FactoryBot.define do
  factory(:admin) do
    name { FFaker::Name.name }
    phone { FFaker::PhoneNumber.phone_number }
  end
end
