require "juggernaut"
class AnimalObserver < ActiveRecord::Observer
  
  def after_update(animal)
    publish(:update, animal)
      
    record_event(animal)
  end
  
  def after_create(animal)
    record_create_event(animal)
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
    unless animal.changed.first == "impressions_count"
      @event = Event.new
      @event.animal_id = animal.id
      @event.update_attributes(:organization_id => animal.organization_id,
        :event_type => "Animal updated", 
        :event_message => "#{animal.name} had #{animal.changed.first} changed from #{animal.changes[animal.changed.first][0] unless animal.changes.blank?} to #{animal.changes[animal.changed.first][1] unless animal.changes.blank?}",
        :record_uuid => animal.uuid
        )
    end
  end
  
  def record_create_event(animal)
    @event = Event.new
    @event.animal_id = animal.id
    @event.update_attributes(:organization_id => animal.organization_id,
      :event_type => "Animal created", 
      :event_message => "#{animal.name} was created.",
      :record_uuid => animal.uuid
      )
  end
  
  
end
