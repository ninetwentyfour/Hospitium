require "juggernaut"
class ShelterObserver < ActiveRecord::Observer
  
  def after_update(shelter)
      publish(:update, shelter)
  end
  
  def publish(type, shelter)
    Juggernaut.url = "redis://redistogo:6d5dd92f93438cd7b67139a6c57acd16@stingfish.redistogo.com:9535/"
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
