class AdoptAnimalObserver < ActiveRecord::Observer
  observe :adopt_animal
  
  # def after_create(adopt_animal)      
  #     record_event(adopt_animal)
  # end
  
  # def before_destroy(adopt_animal)
  #   record_return_event(adopt_animal)
  # end
  
  # def record_event(adopt_animal)
  #   event_hash = { :type => "Animal Adopted", 
  #                  :message => "#{adopt_animal.name} was adopted to #{adopt_animal.first_name} #{adopt_animal.last_name}", 
  #                  :organization => adopt_animal.animal.organization_id, 
  #                  :uuid => adopt_animal.animal.uuid, 
  #                  :animal => adopt_animal.animal_id,
  #                  :related_id => adopt_animal.adoption_contact_id,
  #                  :related_name => "adoption_contact"
  #                }
  #   Event.record_event(event_hash)
  # end
  
  # def record_return_event(adopt_animal)
  #   event_hash = { :type => "Animal Returned", 
  #                  :message => "#{adopt_animal.name} was returned by #{adopt_animal.first_name} #{adopt_animal.last_name}", 
  #                  :organization => adopt_animal.animal.organization_id, 
  #                  :uuid => adopt_animal.animal.uuid, 
  #                  :animal => adopt_animal.animal_id,
  #                  :related_id => adopt_animal.adoption_contact_id,
  #                  :related_name => "adoption_contact"
  #                }
  #   Event.record_event(event_hash)
  # end
  
  
end
