require 'simplecov'
require 'coveralls'

# SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
#   SimpleCov::Formatter::HTMLFormatter,
#   Coveralls::SimpleCov::Formatter
# ]
# SimpleCov.start 'rails'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require "paperclip/matchers"
require "cancan/matchers"
require 'database_cleaner'
require 'public_activity/testing'

PublicActivity.enabled = false

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/*.rb')].each { |f| require f }

def load_factories
  # temporary fix to include factory_girl until we do it the right way
  Dir[Rails.root.join('spec/support/factories/**/*.rb')].each { |f| load f } unless Rails.env.production?
end

load_factories

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.order = "random"

  config.include Paperclip::Shoulda::Matchers
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  #config.use_transactional_fixtures = true
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  
  config.include Devise::TestHelpers, :type => :controller
  config.include ControllerMacros, :type => :controller
end
