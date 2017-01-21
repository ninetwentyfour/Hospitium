require 'juggernaut'

class AnimalObserver < ActiveRecord::Observer
  def after_update(animal)
    publish(:update, animal)
  end

  def publish(type, animal)
    Rails.logger.info "STILL HITTING CALLBACKs"
    # Juggernaut.url = ENV['JUGG_URL']
    # Juggernaut.publish("/observer/#{animal.id}", {
    #   id: animal.id,
    #   type: type,
    #   klass: animal.class.name,
    #   record: animal.changes
    # })
    ActionCable.server.broadcast "bip_#{animal.id}",
      record: animal.changes
  end
end
