# relinquish animal is the join table between aniamals and relinquishment contacts
class RelinquishAnimal < ActiveRecord::Base
  belongs_to :animal
  belongs_to :relinquishment_contact
  
  attr_accessible :relinquishment_contact_id, :animal_id
  
  delegate :name, :to => :animal, :allow_nil => true
  delegate :first_name, :last_name, :to => :relinquishment_contact, :allow_nil => true
  
end