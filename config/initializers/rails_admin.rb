RailsAdmin.config do |config|
  config.authorize_with :cancan
  config.model AnimalSex do
      visible false
  end
  config.model SpayNeuter do
      visible false
  end
  config.model Biter do
      visible false
  end
end