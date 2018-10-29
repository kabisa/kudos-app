# frozen_string_literal: true

require "database_cleaner"

DatabaseCleaner.clean_with(:truncation)

10.times do |i|
  name = Faker::Name.unique.first_name
  User.create(name: name,
              email: "#{name.downcase}@example.com",
              password: "fakepassword",
              password_confirmation: "fakepassword"
  )
end

100.times do |i|
  sender = User.offset(rand(User.count)).first

  Post.create(
    sender: sender,
    receivers: User.limit(rand(1..5)).order("RANDOM()").where.not(id: sender.id),
    message: Faker::ChuckNorris.fact,
    kudos: rand(1..500)
  )
end
