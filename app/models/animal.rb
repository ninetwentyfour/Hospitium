class Animal < ActiveRecord::Base
  belongs_to :organization
  belongs_to :species
  belongs_to :shelter
  
  before_create :create_uuid
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
end
