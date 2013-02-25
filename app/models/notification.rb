class Notification < ActiveRecord::Base
  
  after_create :send_public_tweet
  after_update :send_public_tweet
  
  attr_accessible :message, :status_type
  
  def send_public_tweet
    message = "#{self.status_type}! #{self.message.slice(0, 100)}"
    TwitterAccount.twitter_post(message, 1)
  end
end
