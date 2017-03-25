require 'juggernaut'

class UserObserver < ActiveRecord::Observer
  def after_update(user)
    publish(:update, user) unless user.no_send_email
  end

  def publish(_type, user)
    # Juggernaut.url = ENV['JUGG_URL']
    # Juggernaut.publish("/observer/user/#{user.id}", {
    #   id: user.id,
    #   type: type,
    #   klass: user.class.name,
    #   record: user.changes
    # })
    ActionCable.server.broadcast "bip_#{user.id}",
                                 record: user.changes
  end
end
