require 'juggernaut'

class ShotObserver < ActiveRecord::Observer
  def after_update(shot)
    publish(:update, shot)
  end

  def publish(type, shot)
    # Juggernaut.url = ENV['JUGG_URL']
    # Juggernaut.publish("/observer/shot/#{shot.id}", {
    #   id: shot.id,
    #   type: type,
    #   klass: shot.class.name,
    #   record: shot.changes
    # })
    ActionCable.server.broadcast "bip_#{shot.id}",
      record: shot.changes
  end
end
