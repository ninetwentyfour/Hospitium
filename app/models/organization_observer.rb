require "juggernaut"
class OrganizationObserver < ActiveRecord::Observer
  
  def after_update(organization)
      publish(:update, organization)
  end
  
  def publish(type, organization)
    Juggernaut.url = "redis://redistogo:6d5dd92f93438cd7b67139a6c57acd16@stingfish.redistogo.com:9535/"
    Juggernaut.publish("/observer/organization/#{organization.id}", {
      :id     => organization.id, 
      :type   => type, 
      :klass  => organization.class.name,
      :record => organization.changes
    })
    # Juggernaut.publish("/observer/animal/index", {
    #   :id     => animal.uuid, 
    #   :type   => type, 
    #   :klass  => animal.class.name,
    #   :record => animal.changes
    # })
  end
  
  
end
