require "juggernaut"
class OrganizationObserver < ActiveRecord::Observer

  def after_update(organization)
    publish(:update, organization)
  end

  def publish(type, organization)
    # Juggernaut.url = ENV['JUGG_URL']
    # Juggernaut.publish("/observer/organization/#{organization.id}", {
    #   :id     => organization.id,
    #   :type   => type,
    #   :klass  => organization.class.name,
    #   :record => organization.changes
    # })
    ActionCable.server.broadcast "bip_#{organization.id}",
      record: organization.changes
  end
end
