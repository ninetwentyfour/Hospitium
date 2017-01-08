require 'simplecov'
require 'coveralls'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'paperclip/matchers'
require 'cancan/matchers'
require 'database_cleaner'
require 'public_activity/testing'
require 'capybara/email/rspec'

require 'capybara/rspec'
require 'capybara/poltergeist'
# Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors: false})
end
Capybara.javascript_driver = :poltergeist
Capybara.server_port = 3001
Capybara.app_host = 'http://localhost:3001'

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
  config.order = 'random'

  config.include Paperclip::Shoulda::Matchers

  config.use_transactional_fixtures = false

  config.before :each do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
    else
      DatabaseCleaner.strategy = :truncation
    end
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  [:controller, :view, :request].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess, :type => type
    config.include ::Rails::Controller::Testing::TemplateAssertions, :type => type
    config.include ::Rails::Controller::Testing::Integration, :type => type
  end
  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.include Devise::TestHelpers, :type => :controller
  config.include ControllerMacros, :type => :controller
  config.include Warden::Test::Helpers, :type => :feature
  config.include FeatureMacros, :type => :feature
  config.include BestInPlace::TestHelpers, :type => :feature
end
