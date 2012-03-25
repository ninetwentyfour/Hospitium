class AnimalSex < ActiveRecord::Base
  has_paper_trail
  default_scope :order => "created_at ASC"
  has_many :animals
  
  # show the link in the admin UI instead of the link id
  def show_sex_label_method
    "#{self.sex}"
  end
end
