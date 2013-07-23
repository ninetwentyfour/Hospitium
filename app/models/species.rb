class Species < ActiveRecord::Base
  include CommonScopes

  belongs_to :organization
  has_many :animals
  before_create :create_uuid

  attr_accessible :name
  
  validates_presence_of :name, :organization_id
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  def report_display_name
    "#{self.name}"
  end
end
