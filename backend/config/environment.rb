# frozen_string_literal: true

# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Seed the Faker instance.
Faker::Config.random = Random.new(Settings.faker_seed)
