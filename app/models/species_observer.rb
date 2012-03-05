require "juggernaut"
class SpeciesObserver < ActiveRecord::Observer
  
  def after_update(species)
      publish(:update, species)
  end
  
  def publish(type, species)
    Juggernaut.url = "redis://redistogo:c1e5ec10fe92d5ed2ff683e28a4eb809@carp.redistogo.com:9525/"
    Juggernaut.publish("/observer/species/#{species.id}", {
      :id     => species.id, 
      :type   => type, 
      :klass  => species.class.name,
      :record => species.changes
    })
    # Juggernaut.publish("/observer/animal/index", {
    #   :id     => animal.uuid, 
    #   :type   => type, 
    #   :klass  => animal.class.name,
    #   :record => animal.changes
    # })
  end
  
  
end
