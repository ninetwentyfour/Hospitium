require "juggernaut"
class ShelterObserver < ActiveRecord::Observer
  
  def after_update(shelter)
      publish(:update, shelter)
  end
  
  def publish(type, shelter)
    Juggernaut.url = "redis://redistogo:c1e5ec10fe92d5ed2ff683e28a4eb809@carp.redistogo.com:9525/"
    Juggernaut.publish("/observer/shelter/#{shelter.id}", {
      :id     => shelter.id, 
      :type   => type, 
      :klass  => shelter.class.name,
      :record => shelter.changes
    })
    # Juggernaut.publish("/observer/animal/index", {
    #   :id     => animal.uuid, 
    #   :type   => type, 
    #   :klass  => animal.class.name,
    #   :record => animal.changes
    # })
  end
  
  
end
