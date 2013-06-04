class Shot < ActiveRecord::Base
  before_create :create_uuid
  
  belongs_to :animal
  
  attr_accessible :name, :animal_id, :expires, :last_administered

  validates_presence_of :name, :animal_id
  
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
end
