# frozen_string_literal: true

FactoryBot.define do
  factory(:amount) do
    price { rand(10_000) }
    admin { create(:admin) }
  end
end
