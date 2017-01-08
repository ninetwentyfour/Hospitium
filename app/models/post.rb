class Post < ActiveRecord::Base

  before_create :set_slug
  # after_create :send_public_tweet
  # after_update :send_public_tweet

  attr_accessible :author, :title, :content, :slug

  #used to create url for posts
  def to_param
    slug
  end

  def set_slug
    self.slug = self.title.parameterize
  end

  def send_public_tweet
    return unless Rails.env.production?
    link = ShortLink.shorten_link("https://hospitium.co/posts/#{self.slug}")
    message = "#{self.title.slice(0, 100)} - #{link}"
    TwitterAccount.twitter_post(message, 1)
  end

end
