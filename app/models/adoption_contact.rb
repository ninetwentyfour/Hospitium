class AdoptionContact < ActiveRecord::Base
  has_paper_trail
  belongs_to :animal
  belongs_to :organization
  before_create :modify_phone_number
  before_update :modify_phone_number
  
  validates_presence_of :first_name, :last_name, :address
  
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
  
  def show_name_label_method
    "#{self.first_name} #{self.last_name}"
  end
  
  def modify_phone_number
    unless self.phone.blank?
      self.phone = self.phone.delete("^0-9")
    end
  end
end
