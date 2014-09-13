class FosterAnimal < ActiveRecord::Base
  belongs_to :animal
  belongs_to :foster_contact

  attr_accessible :foster_contact_id, :animal_id
  
  delegate :name, :to => :animal, :allow_nil => true
  delegate :first_name, :last_name, :to => :foster_contact, :allow_nil => true

end