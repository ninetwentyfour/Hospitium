require "juggernaut"
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
      :id     => user.id, 
      :type   => type, 
      :klass  => user.class.name,
      :record => user.changes
    })
  end
  
  def send_user_confirmed_email(user)
    unless Rails.env.test?
      $statsd.increment 'user.activated'
      Thread.new do
        url = "http://sendgrid.com/api/mail.send.json?api_user=#{ENV['SENDGRID_USERNAME']}&api_key=#{ENV['SENDGRID_PASSWORD']}&to=contact@travisberry.com&subject=Hospitium%20-%20User%20Confirmed&text=#{URI::encode(user.username)}%20confirmed%20an%20account.%20#{URI::encode(user.email)}%20in%20organization%20#{URI::encode(user.organization_name)}&from=contact@hospitium.co"
        resp = Net::HTTP.get_response(URI.parse(url))
        data = resp.body
        result = JSON.parse(data)
        if result.has_key? 'Error'
           raise "web service error"
        end
      end
    end
  end
  
end
