class Notification < ActiveRecord::Base
  has_paper_trail
  after_create :send_public_tweet
  after_update :send_public_tweet
  
  def send_public_tweet
    account = TwitterAccount.find_by_user_id(1)
    Twitter.configure do |config|
      config.consumer_key = TwitterAccount::CONSUMER_KEY
      config.consumer_secret = TwitterAccount::CONSUMER_SECRET
      config.oauth_token = account.oauth_token
      config.oauth_token_secret = account.oauth_token_secret
    end
    client = Twitter::Client.new
    #begin
    client.update("#{self.status_type}! #{self.message.to_html.slice(0, 100)}")
    return true
  end
end
