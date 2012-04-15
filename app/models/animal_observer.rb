require "juggernaut"
class AnimalObserver < ActiveRecord::Observer
  
  def after_update(animal)
      publish(:update, animal)
      
      record_event(animal)
  end
  
  def publish(type, animal)    
    Juggernaut.url = ENV['JUGG_URL']
    Juggernaut.publish("/observer/#{animal.uuid}", {
      :id     => animal.uuid, 
      :type   => type, 
      :klass  => animal.class.name,
      :record => animal.changes
    })
  end
  
  def record_event(animal)
    @event = AnimalEvent.new
    @event.animal_id = animal.id
    @event.update_attributes(:event_type => "#{animal.changed.first} updated", :event_message => animal.changes.to_json)
  end
  
  
end
