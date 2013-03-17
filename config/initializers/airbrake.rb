if Rails.env == "production"
  Airbrake.configure do |config|
    config.api_key = ENV['AIRBRAKE_API_KEY']
    config.ignore << "ActionController::RoutingError"
    # config.async = true
  end
end
