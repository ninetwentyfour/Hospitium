# this creates the UUID for the models
module UUIDHelper
  def before_create()
    self.uuid = UUID.random_create().to_s
  end
end