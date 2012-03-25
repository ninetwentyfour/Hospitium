require "juggernaut"
class AdoptionContactObserver < ActiveRecord::Observer
  
  def after_update(adoption_contact)
      publish(:update, adoption_contact)
  end
  
  def publish(type, adoption_contact)
    Juggernaut.url = "redis://redistogo:6d5dd92f93438cd7b67139a6c57acd16@stingfish.redistogo.com:9535/"
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
