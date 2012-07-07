class SpayNeuter < ActiveRecord::Base
  has_paper_trail
  default_scope :order => "created_at ASC"
  has_many :animals
  
  attr_accessible :spay
  
  # show the link in the admin UI instead of the link id
  def show_spay_label_method
    "#{self.spay}"
  end
end
