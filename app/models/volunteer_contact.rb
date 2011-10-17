class VolunteerContact < ActiveRecord::Base
  has_paper_trail
  belongs_to :organization
  before_create :create_uuid
  
  # settings for rails admin views
  rails_admin do
    object_label_method do
      :show_name_label_method # show the user email in the admin UI instead of the user id
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
  
  def show_name_label_method
    "#{self.first_name} #{self.last_name}"
  end
  
end
