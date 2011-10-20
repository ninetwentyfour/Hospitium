class Biter < ActiveRecord::Base
  has_paper_trail
  default_scope :order => "created_at ASC"
  has_many :animals
  
  rails_admin do
    object_label_method do
      :show_value_label_method # show the link in the admin UI instead of the link id
    end
    show do

    end
    create do

    end
    edit do

    end
    list do

    end
  end
  
  # show the link in the admin UI instead of the link id
  def show_value_label_method
    "#{self.value}"
  end
end