class AnimalColor < ActiveRecord::Base
  include CommonScopes

  belongs_to :organization
  has_many :animals
  
  before_create :create_uuid
  
  validates_presence_of :color, :organization_id
  
  attr_accessible :color
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  def report_display_name
    "#{self.color}"
  end
  
end
