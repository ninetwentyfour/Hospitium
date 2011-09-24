RailsAdmin.config do |config|
  config.authorize_with :cancan
  config.model User do
      visible false
  end
end