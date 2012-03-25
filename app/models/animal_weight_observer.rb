require "juggernaut"
class AnimalWeightObserver < ActiveRecord::Observer
  
  def after_update(animal_weight)
      publish(:update, animal_weight)
  end
  
  def publish(type, animal_weight)
    Juggernaut.url = "redis://redistogo:6d5dd92f93438cd7b67139a6c57acd16@stingfish.redistogo.com:9535/"
    Juggernaut.publish("/observer/animal_weight/#{animal_weight.id}", {
      :id     => animal_weight.id, 
      :type   => type, 
      :klass  => animal_weight.class.name,
      :record => animal_weight.changes
    })
    # Juggernaut.publish("/observer/animal/index", {
    #   :id     => animal.uuid, 
    #   :type   => type, 
    #   :klass  => animal.class.name,
    #   :record => animal.changes
    # })
  end
  
  
end
