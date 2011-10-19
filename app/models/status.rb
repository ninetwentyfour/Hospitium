class Status < ActiveRecord::Base
  has_paper_trail
  belongs_to :organization
  default_scope :order => "created_at ASC"
  has_many :animals
  
  rails_admin do
    object_label_method do
      :show_status_label_method # show the link in the admin UI instead of the link id
    end
    show do
      exclude_fields :organization
    end
    create do
      group :animals do
        hide
      end
    end
    edit do
      group :animals do
        hide
      end
    end
    list do
      exclude_fields :organization
    end
  end
  
  # show the link in the admin UI instead of the link id
  def show_status_label_method
    "#{self.status}"
  end
end
