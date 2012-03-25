# relinquish animal is the join table between aniamals and relinquishment contacts
class RelinquishAnimal < ActiveRecord::Base
  belongs_to :animal
  belongs_to :relinquishment_contact
  
  attr_accessible :relinquishment_contact_id, :animal_id
  
end