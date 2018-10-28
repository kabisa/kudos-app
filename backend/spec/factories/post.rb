# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    sender { }
    receivers { [] }
    message { Faker::ChuckNorris.fact }
    kudos { rand(1..500) }
  end
end
