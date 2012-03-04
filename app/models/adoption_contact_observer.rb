require "juggernaut"
class AdoptionContactObserver < ActiveRecord::Observer
  
  def after_update(adoption_contact)
      publish(:update, adoption_contact)
  end
  
  def publish(type, adoption_contact)
    Juggernaut.url = "redis://redistogo:c1e5ec10fe92d5ed2ff683e28a4eb809@carp.redistogo.com:9525/"
    Juggernaut.publish("/observer/adopt_contact/#{adoption_contact.id}", {
      :id     => adoption_contact.id, 
      :type   => type, 
      :klass  => adoption_contact.class.name,
      :record => adoption_contact.changes
    })
    # Juggernaut.publish("/observer/animal/index", {
    #   :id     => animal.uuid, 
    #   :type   => type, 
    #   :klass  => animal.class.name,
    #   :record => animal.changes
    # })
  end
  
  
end
