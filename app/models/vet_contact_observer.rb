require 'juggernaut'

class VetContactObserver < ActiveRecord::Observer
  def after_update(vet_contact)
    publish(:update, vet_contact)
  end

  def publish(_type, vet_contact)
    # Juggernaut.url = ENV['JUGG_URL']
    # Juggernaut.publish("/observer/vet_contact/#{vet_contact.id}", {
    #   id: vet_contact.id,
    #   type: type,
    #   klass: vet_contact.class.name,
    #   record: vet_contact.changes
    # })
    ActionCable.server.broadcast "bip_#{vet_contact.id}",
                                 record: vet_contact.changes
  end
end
