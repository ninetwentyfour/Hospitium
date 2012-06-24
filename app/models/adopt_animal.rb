# adopt animal is the join table between aniamals and adoption contacts
class AdoptAnimal < ActiveRecord::Base
  belongs_to :animal
  belongs_to :adoption_contact

  attr_accessible :adoption_contact_id, :animal_id
  
  delegate :name, :to => :animal, :allow_nil => true
  delegate :first_name, :last_name, :to => :adoption_contact, :allow_nil => true

end