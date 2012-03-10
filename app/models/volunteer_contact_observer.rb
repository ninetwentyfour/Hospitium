require "juggernaut"
class VolunteerContactObserver < ActiveRecord::Observer
  
  def after_update(volunteer_contact)
      publish(:update, volunteer_contact)
  end
  
  def publish(type, volunteer_contact)
    Juggernaut.url = "redis://redistogo:c1e5ec10fe92d5ed2ff683e28a4eb809@carp.redistogo.com:9525/"
    Juggernaut.publish("/observer/volunteer_contact/#{volunteer_contact.id}", {
      :id     => volunteer_contact.id, 
      :type   => type, 
      :klass  => volunteer_contact.class.name,
      :record => volunteer_contact.changes
    })
    # Juggernaut.publish("/observer/animal/index", {
    #   :id     => animal.uuid, 
    #   :type   => type, 
    #   :klass  => animal.class.name,
    #   :record => animal.changes
    # })
  end
  
  
end
