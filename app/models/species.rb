class Species < ActiveRecord::Base
  has_paper_trail
  default_scope :order => "name ASC"
  belongs_to :organization
  has_many :animals
  before_create :create_uuid
  
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
end
