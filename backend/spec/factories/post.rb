FactoryBot.define do
  factory :post do
    sender {}
    receivers {[]}
    message { Faker::Company.bs }
    kudos { rand(1..500) }
  end
end