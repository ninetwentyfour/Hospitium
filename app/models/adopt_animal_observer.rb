class AdoptAnimalObserver < ActiveRecord::Observer
  observe :adopt_animal
  
  def after_create(adopt_animal)      
      record_event(adopt_animal)
  end
  
  def before_destroy(adopt_animal)
    record_event2(adopt_animal)
  end
  

  
  def record_event(adopt_animal)
    @event = AnimalEvent.new
    @event.animal_id = adopt_animal.animal_id
    @event.update_attributes(:event_type => "Animal Adopted", 
      :event_message => "#{adopt_animal.name} was adopted to #{adopt_animal.first_name} #{adopt_animal.last_name}",
      :related_model_name => "adoption_contact",
      :related_model_id => adopt_animal.adoption_contact_id
    )
  end
  
  def record_event2(adopt_animal)
    @event = AnimalEvent.new
    @event.animal_id = adopt_animal.animal_id
    @event.update_attributes(:event_type => "Animal Returned", 
      :event_message => "#{adopt_animal.name} was returned by #{adopt_animal.first_name} #{adopt_animal.last_name}",
      :related_model_name => "adoption_contact",
      :related_model_id => adopt_animal.adoption_contact_id
    )
  end
  
  
end
