# frozen_string_literal: true

require "database_cleaner"

DatabaseCleaner.clean_with(:truncation)

5.times do |i|
  User.create(name: Faker::Name.first_name,
              email: Faker::Internet.email,
              password: "fakepassword",
              password_confirmation: "fakepassword"
  )
end

Post.create(
  sender: User.first,
  receivers: [User.last],
  message: Faker::Company.bs,
  kudos: rand(1..500)
)

Post.create(
  sender: User.second,
  receivers: User.last(2),
  message: Faker::Company.bs,
  kudos: rand(1..500)
)

100.times do |i|
  Post.create(
    sender: User.second,
    receivers: User.last(3),
    message: Faker::Company.bs,
    kudos: rand(1..500)
  )
end
