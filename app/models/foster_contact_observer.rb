require "juggernaut"
class FosterContactObserver < ActiveRecord::Observer
  
  def after_update(foster_contact)
      publish(:update, foster_contact)
  end
  
  def publish(type, foster_contact)
    Juggernaut.url = ENV['JUGG_URL']
    Juggernaut.publish("/observer/foster_contact/#{foster_contact.id}", {
      :id     => foster_contact.id, 
      :type   => type, 
      :klass  => foster_contact.class.name,
      :record => foster_contact.changes
    })
  end
  
end
