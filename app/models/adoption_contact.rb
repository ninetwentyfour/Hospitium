class AdoptionContact < ActiveRecord::Base
  belongs_to :animal
  
  validates_presence_of :first_name, :last_name, :address
  
  # settings for rails admin views
  rails_admin do
    show do
      exclude_fields :uuid
    end
    create do
      exclude_fields :uuid
    end
    edit do
      exclude_fields :uuid
    end
    list do
      exclude_fields :uuid
    end
  end
end
