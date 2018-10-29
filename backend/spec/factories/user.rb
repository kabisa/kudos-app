# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    email { "#{name.downcase}@example.com" }
    password { Faker::Internet.password }
  end
end
