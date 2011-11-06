class AnimalColor < ActiveRecord::Base
  has_paper_trail
  default_scope :order => "color ASC"
  belongs_to :organization
  before_update :create_uuid
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
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  # show the link in the admin UI instead of the link id
  def show_color_label_method
    "#{self.color}"
  end
  
end
