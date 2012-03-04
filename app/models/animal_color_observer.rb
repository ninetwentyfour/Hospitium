require "juggernaut"
class AnimalColorObserver < ActiveRecord::Observer
  
  def after_update(animal_color)
      publish(:update, animal_color)
  end
  
  def publish(type, animal_color)
    Juggernaut.url = "redis://redistogo:c1e5ec10fe92d5ed2ff683e28a4eb809@carp.redistogo.com:9525/"
    Juggernaut.publish("/observer/animal_color/#{animal_color.id}", {
      :id     => animal_color.id, 
      :type   => type, 
      :klass  => animal_color.class.name,
      :record => animal_color.changes
    })
    # Juggernaut.publish("/observer/animal/index", {
    #   :id     => animal.uuid, 
    #   :type   => type, 
    #   :klass  => animal.class.name,
    #   :record => animal.changes
    # })
  end
  
  
end
