require 'juggernaut'

class StatusObserver < ActiveRecord::Observer
  def after_update(status)
    publish(:update, status)
  end

  def publish(type, status)
    # Juggernaut.url = ENV['JUGG_URL']
    # Juggernaut.publish("/observer/status/#{status.id}", {
    #   id: status.id,
    #   type: type,
    #   klass: status.class.name,
    #   record: status.changes
    # })
    ActionCable.server.broadcast "bip_#{status.id}",
      record: status.changes
  end
end
