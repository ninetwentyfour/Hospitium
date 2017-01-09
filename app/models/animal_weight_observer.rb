require 'juggernaut'

class AnimalWeightObserver < ActiveRecord::Observer

  def after_update(animal_weight)
      publish(:update, animal_weight)
  end

  def publish(type, animal_weight)
    # Juggernaut.url = ENV['JUGG_URL']
    # Juggernaut.publish("/observer/animal_weight/#{animal_weight.id}", {
    #   id: animal_weight.id,
    #   type: type,
    #   klass: animal_weight.class.name,
    #   record: animal_weight.changes
    # })
    ActionCable.server.broadcast "bip_#{animal_weight.id}",
      record: animal_weight.changes
  end
end
