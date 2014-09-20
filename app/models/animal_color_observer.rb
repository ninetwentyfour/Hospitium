require "juggernaut"
class AnimalColorObserver < ActiveRecord::Observer
  
  def after_update(animal_color)
      publish(:update, animal_color)
  end
  
  def publish(type, animal_color)
    Juggernaut.url = ENV['JUGG_URL']
    Juggernaut.publish("/observer/animal_color/#{animal_color.id}", {
      :id     => animal_color.id, 
      :type   => type, 
      :klass  => animal_color.class.name,
      :record => animal_color.changes
    })
  end
end
