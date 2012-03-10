class Status < ActiveRecord::Base
  has_paper_trail
  default_scope :order => "status ASC"
  belongs_to :organization
  has_many :animals
  #belongs_to :organization
  #default_scope :order => "created_at ASC"
  #has_many :animals
  validates_presence_of :status, :organization_id
  
  attr_accessible :status
  
  # show the link in the admin UI instead of the link id
  def show_status_label_method
    "#{self.status}"
  end
end
