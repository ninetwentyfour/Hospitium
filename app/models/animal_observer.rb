require "juggernaut"
class AnimalObserver < ActiveRecord::Observer
  
  def after_update(animal)
      publish(:update, animal)
  end
  
  def publish(type, animal)
    Juggernaut.url = "redis://redistogo:c1e5ec10fe92d5ed2ff683e28a4eb809@carp.redistogo.com:9525/"
    Juggernaut.publish("/observer/#{animal.uuid}", {
      :id     => animal.uuid, 
      :type   => type, 
      :klass  => animal.class.name,
      :record => animal.changes
    })
    # Juggernaut.publish("/observer/animal/index", {
    #   :id     => animal.uuid, 
    #   :type   => type, 
    #   :klass  => animal.class.name,
    #   :record => animal.changes
    # })
  end
  
  
end
