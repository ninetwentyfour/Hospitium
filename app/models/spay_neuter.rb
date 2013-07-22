class SpayNeuter < ActiveRecord::Base
  
  default_scope lambda {order("created_at ASC")}
  has_many :animals
  
  attr_accessible :spay
  
  # show the link in the admin UI instead of the link id
  def show_spay_label_method
    "#{self.spay}"
  end
end
