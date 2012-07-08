class Species < ActiveRecord::Base
  include CommonScopes

  belongs_to :organization
  has_many :animals
  before_create :create_uuid
  validates_presence_of :name, :organization_id
  
  attr_accessible :name
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
end
