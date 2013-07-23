class AnimalColor < ActiveRecord::Base
  include CommonScopes

  belongs_to :organization
  has_many :animals
  
  before_create :create_uuid

  attr_accessible :color
  
  validates_presence_of :color, :organization_id
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  def report_display_name
    "#{self.color}"
  end
  
end
