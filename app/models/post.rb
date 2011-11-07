class Post < ActiveRecord::Base
  CONSUMER_KEY = 'Is9pdOhRRNhx95wGBiWg'
  CONSUMER_SECRET = 'D2WLDX0Fh9EOGAhBJSQFkKs1U2c3ET2a5z2t9JZCrM'
  OPTIONS = {:site => "http://api.twitter.com", :request_endpoint => "http://api.twitter.com"}
  
  has_paper_trail
  after_update :send_public_tweet
  
  def to_params
    "#{id}-#{title.parameterize}"
  end
  # settings for rails admin views
  # rails_admin do
  #   show do
  #     field :title
  #     field :author
  #     field :content
  #   end
  #   create do
  #     #field :title
  #     #field :author
  #     field :content, :text do
  #       ckeditor true
  #     end
  #   end
  #   edit do
  #     #field :title
  #     #field :author
  #     field :content, :text do
  #       ckeditor true
  #     end
  #   end
  #   list do
  #     field :title
  #     field :author
  #     field :content
  #   end
  # end
  def send_public_tweet
    if self.public == 1
      account = TwitterAccount.find_by_user_id(1)
      Twitter.configure do |config|
        config.consumer_key = TwitterAccount::CONSUMER_KEY
        config.consumer_secret = TwitterAccount::CONSUMER_SECRET
        config.oauth_token = account.oauth_token
        config.oauth_token_secret = account.oauth_token_secret
      end
      client = Twitter::Client.new
      #begin
      link = TwitterAccount.shorten_link("http://hospitium.co/posts/#{self.id}-#{self.title.parameterize}")
      client.update("#{self.title} | #{link}")
      return true
    end
  end
  
end
