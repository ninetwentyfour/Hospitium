require 'juggernaut'

class ShelterObserver < ActiveRecord::Observer
  def after_update(shelter)
    publish(:update, shelter)
  end

  def publish(_type, shelter)
    # Juggernaut.url = ENV['JUGG_URL']
    # Juggernaut.publish("/observer/shelter/#{shelter.id}", {
    #   id: shelter.id,
    #   type: type,
    #   klass: shelter.class.name,
    #   record: shelter.changes
    # })
    ActionCable.server.broadcast "bip_#{shelter.id}",
                                 record: shelter.changes
  end
end
