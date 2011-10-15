class AnimalColor < ActiveRecord::Base
  has_paper_trail
  belongs_to :organization
  # settings for rails admin views
  rails_admin do
    object_label_method do
      :show_color_label_method # show the link in the admin UI instead of the link id
    end
    show do
      exclude_fields :uuid, :organization
    end
    create do
      exclude_fields :uuid
    end
    edit do
      exclude_fields :uuid
    end
    list do
      exclude_fields :uuid, :organization
    end
  end
  
  # show the link in the admin UI instead of the link id
  def show_color_label_method
    "#{self.color}"
  end
  
end
