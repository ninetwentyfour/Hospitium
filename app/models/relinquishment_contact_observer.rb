require "juggernaut"
class RelinquishmentContactObserver < ActiveRecord::Observer
  
  def after_update(relinquishment_contact)
      publish(:update, relinquishment_contact)
  end
  
  def publish(type, relinquishment_contact)
    Juggernaut.url = ENV['JUGG_URL']
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
