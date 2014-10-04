require "juggernaut"
class AnimalObserver < ActiveRecord::Observer
  
  def after_update(animal)
    publish(:update, animal)
  end
  
  def publish(type, animal)    
    Juggernaut.url = ENV['JUGG_URL']
    Juggernaut.publish("/observer/#{animal.id}", {
      :id     => animal.id, 
      :type   => type, 
      :klass  => animal.class.name,
      :record => animal.changes
    })
  end  
end
