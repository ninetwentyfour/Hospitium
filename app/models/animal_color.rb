class AnimalColor < ActiveRecord::Base
  has_paper_trail
  #default_scope :order => "color ASC"
  belongs_to :organization
  before_update :create_uuid
  validates_presence_of :color, :organization_id
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  # show the link in the admin UI instead of the link id
  def show_color_label_method
    "#{self.color}"
  end
  
end
