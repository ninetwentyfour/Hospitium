class Post < ActiveRecord::Base
  CONSUMER_KEY = ENV['TWITTER_CONSUMER_KEY']
  CONSUMER_SECRET = ENV['TWITTER_CONSUMER_SECRET']
  OPTIONS = {:site => "http://api.twitter.com", :request_endpoint => "http://api.twitter.com"}
  
  has_paper_trail
  after_create :send_public_tweet
  after_update :send_public_tweet
  
  attr_accessible :author, :title, :content
  
  def to_params
    "#{id}-#{title.parameterize}"
  end
  
  def send_public_tweet
    account = TwitterAccount.find_by_user_id(1)
    Twitter.configure do |config|
      config.consumer_key = TwitterAccount::CONSUMER_KEY
      config.consumer_secret = TwitterAccount::CONSUMER_SECRET
      config.oauth_token = account.oauth_token
      config.oauth_token_secret = account.oauth_token_secret
    end
    client = Twitter::Client.new
    link = TwitterAccount.shorten_link("http://hospitium.co/posts/#{self.id}-#{self.title.parameterize}")
    begin
       client.update("#{self.title.slice(0, 100)} - #{link}")
       return true
     rescue Twitter::Error
       return true
     rescue Exception
       return true
     end
  end
  
end
