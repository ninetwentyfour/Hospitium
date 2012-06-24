class TwitterAccount < ActiveRecord::Base
  
  CONSUMER_KEY = ENV['TWITTER_CONSUMER_KEY']
  CONSUMER_SECRET = ENV['TWITTER_CONSUMER_SECRET']
  OPTIONS = {:site => "http://api.twitter.com", :request_endpoint => "http://api.twitter.com"}
  
  belongs_to :user
  belongs_to :organization
  
  attr_accessible :user_id, :active, :stream_url, :oauth_token, :oauth_token_secret, :oauth_authorize_url
  
  def authorize_url(callback_url = '')
    if self.oauth_authorize_url.blank?
      # Step one, generate a request URL with a request token and secret
      signing_consumer = OAuth::Consumer.new(TwitterAccount::CONSUMER_KEY, TwitterAccount::CONSUMER_SECRET, TwitterAccount::OPTIONS)
      request_token = signing_consumer.get_request_token(:oauth_callback => callback_url)
      self.oauth_token = request_token.token
      self.oauth_token_secret = request_token.secret
      self.oauth_authorize_url = request_token.authorize_url
      self.save!
    end
    self.oauth_authorize_url
  end
  
  def validate_oauth_token(oauth_verifier, callback_url = '')
    begin
      signing_consumer = OAuth::Consumer.new(TwitterAccount::CONSUMER_KEY, TwitterAccount::CONSUMER_SECRET, TwitterAccount::OPTIONS)
      access_token = OAuth::RequestToken.new(signing_consumer, self.oauth_token, self.oauth_token_secret).
                                         get_access_token(:oauth_verifier => oauth_verifier)
      self.oauth_token = access_token.params[:oauth_token]
      self.oauth_token_secret = access_token.params[:oauth_token_secret]
      self.stream_url = "http://twitter.com/#{access_token.params[:screen_name]}"
      self.active = true
    rescue OAuth::Unauthorized
      self.errors.add(:oauth_token, "Invalid OAuth token, unable to connect to twitter")
      self.active = false
    end
    self.save!
  end
  
  #send normla user animal tweet
  def self.twitter_post(message, user)
    begin
      account = TwitterAccount.find_by_user_id(user)
      Twitter.configure do |config|
        config.consumer_key = TwitterAccount::CONSUMER_KEY
        config.consumer_secret = TwitterAccount::CONSUMER_SECRET
        config.oauth_token = account.oauth_token
        config.oauth_token_secret = account.oauth_token_secret
      end
      client = Twitter::Client.new
      #begin
      client.update("#{message}")
      return true
    rescue Twitter::Error
      return true #don't care if tweet doesn't send - just don't throw app error
    end
  end
  
  #anytime a public animal is updated, send a tweet with its link from @hospitium_app
  def self.send_public_update_tweet(animal)
    begin
      account = TwitterAccount.find_by_user_id(1)
      Twitter.configure do |config|
        config.consumer_key = TwitterAccount::CONSUMER_KEY
        config.consumer_secret = TwitterAccount::CONSUMER_SECRET
        config.oauth_token = account.oauth_token
        config.oauth_token_secret = account.oauth_token_secret
      end
      client = Twitter::Client.new
      link = TwitterAccount.shorten_link("http://hospitium.co/animals/#{animal.uuid}")
      client.update("#{animal.name} is ready for adoption at #{link}")
      return true
    rescue Twitter::Error
      return true #don't care if tweet doesn't send - just don't throw app error
    end
  end
  
  def self.send_post_tweet(post)
    account = TwitterAccount.find_by_user_id(1)
    Twitter.configure do |config|
      config.consumer_key = TwitterAccount::CONSUMER_KEY
      config.consumer_secret = TwitterAccount::CONSUMER_SECRET
      config.oauth_token = account.oauth_token
      config.oauth_token_secret = account.oauth_token_secret
    end
    client = Twitter::Client.new
    link = TwitterAccount.shorten_link("http://hospitium.co/posts/#{post.id}-#{post.title.parameterize}")
    begin
       client.update("#{post.title.slice(0, 100)} - #{link}")
       return true
     rescue Twitter::Error
       return true
     rescue Exception
       return true
     end
  end
  
  #create a bitly link
  def self.shorten_link(link)
    #change user and api key to one for biemedia
    bitly = Bitly.new('hospitium',ENV['BITLY_API'])
    page_url = bitly.shorten(link)
    short_url = page_url.short_url
    #fall back to tinyurl if bitly fails
    if short_url.blank?
      short_url = RestClient.get "http://tinyurl.com/api-create.php?url=#{link}"
    end
    
    return short_url
  end
  
end

