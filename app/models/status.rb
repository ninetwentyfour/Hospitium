class Status < ActiveRecord::Base
  include CommonScopes

  belongs_to :organization
  has_many :animals
  #default_scope :order => "created_at ASC"

  attr_accessible :status

  validates_presence_of :status, :organization_id
  
  # show the link in the admin UI instead of the link id
  def show_status_label_method
    "#{self.status}"
  end
  
  def report_display_name
    "#{self.status}"
  end
  
end
