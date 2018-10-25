# frozen_string_literal: true

require "database_cleaner"

DatabaseCleaner.clean_with(:truncation)

10.times do |i|
  User.create(name: Faker::Name.first_name,
              email: Faker::Internet.email,
              password: "fakepassword",
              password_confirmation: "fakepassword"
  )
end

100.times do |i|
  sender = User.offset(rand(User.count)).first

  Post.create(
    sender: sender,
    receivers: User.limit(rand(1..5)).order("RANDOM()").where.not(id: sender.id),
    message: Faker::Company.bs,
    kudos: rand(1..500)
  )
end
