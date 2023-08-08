require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DemoProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.generators.after_generate do |files|
      parsable_files = files.filter { |file| file.end_with?('.rb') }
      system("bundle exec rubocop -A --fail-level=E #{parsable_files.shelljoin}", exception: true)
    end
    # config.middleware.insert_before ActionDispatch::Static, Rack::MethodOverride
    # config.middleware.insert_after Rack::MethodOverride, Warden::Manager
   
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    
  #  config.api_only = true

    #  config.session_store :cookie_store, key: '_interslice_session'
    #  config.middleware.use ActionDispatch::Cookies
    #  config.middleware.use config.session_store, config.session_options

  end
end
