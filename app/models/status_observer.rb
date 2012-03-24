require "juggernaut"
class StatusObserver < ActiveRecord::Observer
  
  def after_update(status)
      publish(:update, status)
  end
  
  def publish(type, status)
    Juggernaut.url = "redis://redistogo:6d5dd92f93438cd7b67139a6c57acd16@stingfish.redistogo.com:9535/"
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
