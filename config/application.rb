require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'sprockets/railtie'
# require 'trashed/railtie'

Bundler.require(:default, Rails.env)


module AnimalTracker
  class Application < Rails::Application
    # Enable the asset pipeline
    # config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    
    config.assets.initialize_on_precompile = false
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'
    config.active_record.default_timezone = :local

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
    
    config.active_record.observers = :animal_observer, :adoption_contact_observer, :animal_color_observer, :animal_weight_observer, :organization_observer, 
      :relinquishment_contact_observer, :shelter_observer, :species_observer, :status_observer, :user_observer, :vet_contact_observer, :volunteer_contact_observer,
      :note_observer, :adopt_animal_observer, :relinquish_animal_observer, :document_observer, :shot_observer
      
    config.active_record.whitelist_attributes = true
    
    #config.middleware.use "PDFKit::Middleware", :print_media_type => true
    
    # setup statsd - this is hackey
    $statsd = Statsd.new ENV['STATSD'], 8125
    # Set the namespace to admin
    $statsd.namespace = "hospitium"
    # config.trashed[:statsd] = $statsd

    # use rack-attack
    config.middleware.use Rack::Attack

    config.to_prepare do
        Devise::SessionsController.layout "login"
        Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "login" }
        Devise::ConfirmationsController.layout "login"
        Devise::UnlocksController.layout "login"            
        Devise::PasswordsController.layout "login"     
    end
  end
end
