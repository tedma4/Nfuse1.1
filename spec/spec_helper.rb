require 'simplecov'
SimpleCov.start
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'rack/test'
require 'rspec/rails'
require 'rspec/mocks'
require 'rspec/collection_matchers'
require 'shoulda/matchers'
require 'json'
require 'capybara/rspec'
require 'factory_girl'
require 'database_cleaner'
require 'faker'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|

  config.include SpecTestHelpers

  config.include FactoryGirl::Syntax::Methods
  # Include the rails route
  config.include Rails.application.routes.url_helpers
  # Selectively run specs..
  config.include RSpec::Rails::RequestExampleGroup, type: :feature

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding :tag #unless environment var.

  config.before(:each) { GC.disable }
  config.after(:each) { GC.enable }

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
