require 'juggernaut'

class AdoptionContactObserver < ActiveRecord::Observer
  def after_update(adoption_contact)
      publish(:update, adoption_contact)
  end

  def publish(type, adoption_contact)
    # Juggernaut.url = ENV['JUGG_URL']
    # Juggernaut.publish("/observer/adopt_contact/#{adoption_contact.id}", {
    #   id: adoption_contact.id,
    #   type: type,
    #   klass: adoption_contact.class.name,
    #   record: adoption_contact.changes
    # })
    Rails.logger.info "HITTING sOBSSSsSSSssass"
    ActionCable.server.broadcast "bip_#{adoption_contact.id}",
      record: adoption_contact.changes
  end
end
