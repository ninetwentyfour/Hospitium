require 'juggernaut'

class SpeciesObserver < ActiveRecord::Observer
  def after_update(species)
    publish(:update, species)
  end

  def publish(type, species)
    # Juggernaut.url = ENV['JUGG_URL']
    # Juggernaut.publish("/observer/species/#{species.id}", {
    #   id: species.id,
    #   type: type,
    #   klass: species.class.name,
    #   record: species.changes
    # })
    ActionCable.server.broadcast "bip_#{species.id}",
      record: species.changes
  end
end
