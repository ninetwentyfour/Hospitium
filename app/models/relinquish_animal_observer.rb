class RelinquishAnimalObserver < ActiveRecord::Observer
  observe :relinquish_animal
  
  def after_create(relinquish_animal)      
      record_event(relinquish_animal)
  end
  
  def before_destroy(relinquish_animal)
    record_event2(relinquish_animal)
  end
  

  
  def record_event(relinquish_animal)
    @event = AnimalEvent.new
    @event.animal_id = relinquish_animal.animal_id
    @event.update_attributes(:event_type => "Animal Relinquished", 
      :event_message => "#{relinquish_animal.animal.name} was relinquished by #{relinquish_animal.relinquishment_contact.first_name} #{relinquish_animal.relinquishment_contact.last_name}",
      :related_model_name => "relinquishment_contact",
      :related_model_id => relinquish_animal.relinquishment_contact_id
    )
  end
  
  def record_event2(relinquish_animal)
    @event = AnimalEvent.new
    @event.animal_id = relinquish_animal.animal_id
    @event.update_attributes(:event_type => "Animal Returned", 
      :event_message => "#{relinquish_animal.animal.name} was returned to #{relinquish_animal.relinquishment_contact.first_name} #{relinquish_animal.relinquishment_contact.last_name}",
      :related_model_name => "relinquishment_contact",
      :related_model_id => relinquish_animal.relinquishment_contact_id
    )
  end
  
  
end
