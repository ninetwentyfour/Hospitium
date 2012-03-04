require "juggernaut"
class OrganizationObserver < ActiveRecord::Observer
  
  def after_update(organization)
      publish(:update, organization)
  end
  
  def publish(type, organization)
    Juggernaut.url = "redis://redistogo:c1e5ec10fe92d5ed2ff683e28a4eb809@carp.redistogo.com:9525/"
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
