# relinquish animal is the join table between aniamals and relinquishment contacts
class RelinquishAnimal < ActiveRecord::Base
  belongs_to :animal
  belongs_to :relinquishment_contact
  
  # settings for rails admin views
  rails_admin do
    visible false # dont show permissions to users in rails admin UI
  end
  
end