class Post < ActiveRecord::Base
  
  has_paper_trail
  after_create :send_public_tweet
  after_update :send_public_tweet
  
  attr_accessible :author, :title, :content
  
  #used to create url for posts
  def to_params
    "#{id}-#{title.parameterize}"
  end
  
  def send_public_tweet
    TwitterAccount.send_post_tweet(self)
  end
  
end
