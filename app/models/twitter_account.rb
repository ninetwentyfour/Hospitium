class TwitterAccount < ActiveRecord::Base
  
  CONSUMER_KEY = ENV['TWITTER_CONSUMER_KEY']
  CONSUMER_SECRET = ENV['TWITTER_CONSUMER_SECRET']
  OPTIONS = {:site => "https://api.twitter.com", :request_endpoint => "https://api.twitter.com"}
  
  belongs_to :user
  belongs_to :organization
  
  attr_accessible :user_id
  
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
      self.stream_url = "https://twitter.com/#{access_token.params[:screen_name]}"
      self.active = true
    rescue OAuth::Unauthorized
      self.errors.add(:oauth_token, "Invalid OAuth token, unable to connect to twitter")
      self.active = false
    end
    self.save!
  end
  
  #send normla user animal tweet
  def self.twitter_post(message, user)
    Thread.new do
      begin
        account = TwitterAccount.find_by_user_id(user)
        TwitterAccount.config_twitter(account)
        client = Twitter::Client.new
        #begin
        client.update("#{message}")
        return true
      rescue Twitter::Error
        return true #don't care if tweet doesn't send - just don't throw app error
      end
    end
    return true
  end
  
  def self.config_twitter(account)
    Twitter.configure do |config|
      config.consumer_key = TwitterAccount::CONSUMER_KEY
      config.consumer_secret = TwitterAccount::CONSUMER_SECRET
      config.oauth_token = account.oauth_token
      config.oauth_token_secret = account.oauth_token_secret
    end
  end
  
  
end

