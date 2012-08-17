require "juggernaut"
class UserObserver < ActiveRecord::Observer
  
  def after_update(user)
    unless user.no_send_email == true
      publish(:update, user)
      random_tweet(user)
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
  
  def random_tweet(user)
    if Rails.env == "test"

    else
      rand = [1..6].shuffle.first
      if rand == 1
        @animal = Animal.offset(rand(Animal.count(:conditions => {:public => 1}))).first(:conditions => {:public => 1})
        account = TwitterAccount.find_by_user_id(1)
        Twitter.configure do |config|
          config.consumer_key = TwitterAccount::CONSUMER_KEY
          config.consumer_secret = TwitterAccount::CONSUMER_SECRET
          config.oauth_token = account.oauth_token
          config.oauth_token_secret = account.oauth_token_secret
        end
        client = Twitter::Client.new
        link = TwitterAccount.shorten_link("https://hospitium.co/animals/#{@animal.uuid}")
        begin
           client.update("#{@animal.name} is ready for adoption at #{link}")
           return true
         rescue Twitter::Error
           return true
         rescue Exception
           return true
         end
      elsif rand == 2
        @post = Post.offset(rand(Post.count())).first()
        account = TwitterAccount.find_by_user_id(1)
        Twitter.configure do |config|
          config.consumer_key = TwitterAccount::CONSUMER_KEY
          config.consumer_secret = TwitterAccount::CONSUMER_SECRET
          config.oauth_token = account.oauth_token
          config.oauth_token_secret = account.oauth_token_secret
        end
        client = Twitter::Client.new
        link = TwitterAccount.shorten_link("https://hospitium.co/posts/#{@post.id}-#{@post.title.parameterize}")
        begin
           client.update("#{@post.title.slice(0, 100)} - #{link}")
           return true
         rescue Twitter::Error
           return true
         rescue Exception
           return true
         end
      else
        #do nothing
      end
    end
    
  end
  
  def send_user_confirmed_email(user)
    if Rails.env == "test"

    else
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
