require 'juggernaut'

class UserObserver < ActiveRecord::Observer
  def after_update(user)
    unless user.no_send_email == true
      publish(:update, user)
    end
  end

  def before_save(user)
    unless user.no_send_email == true
      send_user_confirmed_email(user) if user.confirmed_at_changed?
    end
  end

  def publish(type, user)
    Juggernaut.url = ENV['JUGG_URL']
    Juggernaut.publish("/observer/user/#{user.id}", {
      id: user.id,
      type: type,
      klass: user.class.name,
      record: user.changes
    })
  end

  def send_user_confirmed_email(user)
    unless Rails.env.test?
      $statsd.increment 'user.activated'
      client = SendGrid::Client.new(api_key: ENV['SENDGRID_PASSWORD'])
      mail = SendGrid::Mail.new do |m|
        m.to = 'contact@travisberry.com'
        m.from = 'contact@hospitium.co'
        m.subject = 'Hospitium User Confirmed'
        m.text = "#{user.username} confirmed an account. #{user.email} in organization #{user.organization_name}"
      end
      client.send(mail)
    end
  rescue => e
    notify_airbrake(e)
  end
end
