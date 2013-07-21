class Post < ActiveRecord::Base
  
  after_create :send_public_tweet
  after_update :send_public_tweet

  attr_accessible :author, :title, :content
  
  #used to create url for posts
  def to_params
    "#{id}-#{title.parameterize}"
  end
  
  def send_public_tweet
    link = ShortLink.shorten_link("https://hospitium.co/posts/#{self.id}-#{self.title.parameterize}")
    message = "#{self.title.slice(0, 100)} - #{link}"
    TwitterAccount.twitter_post(message, 1)
  end
  
end
