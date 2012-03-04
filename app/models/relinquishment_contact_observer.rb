require "juggernaut"
class RelinquishmentContactObserver < ActiveRecord::Observer
  
  def after_update(relinquishment_contact)
      publish(:update, relinquishment_contact)
  end
  
  def publish(type, relinquishment_contact)
    Juggernaut.url = "redis://redistogo:c1e5ec10fe92d5ed2ff683e28a4eb809@carp.redistogo.com:9525/"
    Juggernaut.publish("/observer/relinquishment_contact/#{relinquishment_contact.id}", {
      :id     => relinquishment_contact.id, 
      :type   => type, 
      :klass  => relinquishment_contact.class.name,
      :record => relinquishment_contact.changes
    })
    # Juggernaut.publish("/observer/animal/index", {
    #   :id     => animal.uuid, 
    #   :type   => type, 
    #   :klass  => animal.class.name,
    #   :record => animal.changes
    # })
  end
  
  
end
