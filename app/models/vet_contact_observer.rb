require "juggernaut"
class VetContactObserver < ActiveRecord::Observer
  
  def after_update(vet_contact)
      publish(:update, vet_contact)
  end
  
  def publish(type, vet_contact)
    Juggernaut.url = ENV['JUGG_URL']
    Juggernaut.publish("/observer/vet_contact/#{vet_contact.id}", {
      :id     => vet_contact.id, 
      :type   => type, 
      :klass  => vet_contact.class.name,
      :record => vet_contact.changes
    })
    # Juggernaut.publish("/observer/animal/index", {
    #   :id     => animal.uuid, 
    #   :type   => type, 
    #   :klass  => animal.class.name,
    #   :record => animal.changes
    # })
  end
  
  
end
