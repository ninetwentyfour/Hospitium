require "juggernaut"
class StatusObserver < ActiveRecord::Observer
  
  def after_update(status)
      publish(:update, status)
  end
  
  def publish(type, status)
    Juggernaut.url = "redis://redistogo:c1e5ec10fe92d5ed2ff683e28a4eb809@carp.redistogo.com:9525/"
    Juggernaut.publish("/observer/status/#{status.id}", {
      :id     => status.id, 
      :type   => type, 
      :klass  => status.class.name,
      :record => status.changes
    })
    # Juggernaut.publish("/observer/animal/index", {
    #   :id     => animal.uuid, 
    #   :type   => type, 
    #   :klass  => animal.class.name,
    #   :record => animal.changes
    # })
  end
  
  
end
