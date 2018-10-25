# frozen_string_literal: true

GraphdocRuby.configure do |config|
  config.endpoint = "/schema/schema.json"
  config.schema_name = "KudosBackendSchema"
  config.run_time_generation = Rails.env.development?
end
