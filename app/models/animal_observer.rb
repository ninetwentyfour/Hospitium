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
      event_hash = { :type => "Animal updated", 
                     :message => "#{animal.name} had #{animal.changed.first} changed from #{animal.changes[animal.changed.first][0] unless animal.changes.blank?} to #{animal.changes[animal.changed.first][1] unless animal.changes.blank?}", 
                     :organization => animal.organization_id, 
                     :uuid => animal.uuid, 
                     :animal => animal.id 
                   }
      Event.record_event(event_hash)
    end
  end
  
  def record_create_event(animal)
    event_hash = { :type => "Animal created", 
                   :message => "#{animal.name} was created.", 
                   :organization => animal.organization_id, 
                   :uuid => animal.uuid, 
                   :animal => animal.id 
                 }
    Event.record_event(event_hash)
  end
  
  
end
