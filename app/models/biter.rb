class Biter < ActiveRecord::Base
  
  default_scope :order => "created_at ASC"
  has_many :animals
  
  attr_accessible :value
  
  # show the link in the admin UI instead of the link id
  def show_value_label_method
    "#{self.value}"
  end
end
