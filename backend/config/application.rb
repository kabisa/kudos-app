# frozen_string_literal: true

require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module KudosBackend
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join("lib")

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "http://localhost:9090"
        resource "*",
                 headers: :any,
                 methods: [:get, :post, :options],
                 credentials: true
        # expose: ["Access-Control-Allow-Credentials: true"]
      end
    end
  end
end
