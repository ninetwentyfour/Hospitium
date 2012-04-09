require "juggernaut"
class UserObserver < ActiveRecord::Observer
  
  def after_update(user)
      publish(:update, user)
  end
  
  
  def publish(type, user)
    Juggernaut.url = ENV['JUGG_URL']
    Juggernaut.publish("/observer/user/#{user.id}", {
      :id     => user.id, 
      :type   => type, 
      :klass  => user.class.name,
      :record => user.changes
    })
    # Juggernaut.publish("/observer/animal/index", {
    #   :id     => animal.uuid, 
    #   :type   => type, 
    #   :klass  => animal.class.name,
    #   :record => animal.changes
    # })
  end
  
  
  
end
