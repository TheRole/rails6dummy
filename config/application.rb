require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails6dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Add to autoload paths an external folder with common Models, Controllres, Specs and so on
    config.autoload_paths += Dir[Rails.root.join('../', 'rspec_specs', '_TEST_APP_', 'controllers', '**/')]
    config.autoload_paths += Dir[Rails.root.join('../', 'rspec_specs', '_TEST_APP_', 'models', '**/')]

    # External place for FactoryBot factories
    config.factory_bot.definition_file_paths += Dir[Rails.root.join('../', 'rspec_specs', 'factories')]

    # External place for Migrations
    config.paths['db/migrate'].push Rails.root.join('../', 'rspec_specs', '_TEST_APP_', 'db', 'migrate').to_s

    # Add external routes
    config.paths["config/routes.rb"].push Rails.root.join('../', 'rspec_specs', '_TEST_APP_', 'routes.rb')

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
