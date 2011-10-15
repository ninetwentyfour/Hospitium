class FacebookAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  
  # settings for rails admin views
  rails_admin do
    object_label_method do
      :show_facebookurl_label_method # show the user email in the admin UI instead of the user id
    end
  end
  
  
  # Stubbed out! Does no (good) error checking!

  # Get these from facebook!
  FACEBOOK_CLIENT_ID = '251551181558533'
  FACEBOOK_CLIENT_SECRET = '7a851adba5a39b9862204971d8c16ea2'

  def authorize_url(callback_url = '')
    if self.oauth_authorize_url.blank?
      self.oauth_authorize_url = "https://graph.facebook.com/oauth/authorize?client_id=#{FACEBOOK_CLIENT_ID}&redirect_uri=#{callback_url}&scope=offline_access,publish_stream"
      self.save!
    end
    self.oauth_authorize_url
  end
  
  def validate_oauth_token(oauth_verifier, callback_url = '')
    response = RestClient.get 'https://graph.facebook.com/oauth/access_token', :params => {
                   :client_id => FACEBOOK_CLIENT_ID,
                   :redirect_uri => "#{callback_url.html_safe}",
                   :client_secret => FACEBOOK_CLIENT_SECRET,
                   :code => "#{oauth_verifier.html_safe}"
                }
    pair = response.body.split("&")[0].split("=")
    if (pair[0] == "access_token")
      self.access_token = pair[1]
      response = RestClient.get 'https://graph.facebook.com/me', :params => { :access_token => self.access_token }
      self.stream_url = JSON.parse(response.body)["link"]
      self.active = true
    else
      self.errors.add(:oauth_verifier, "Invalid token, unable to connect to facebook: #{pair[1]}")
      self.active = false
    end
    #self.user_id = current_user.id
    self.save!
  end
  
  def self.post(message, user)
    account = FacebookAccount.find_by_user_id(user)
    RestClient.post 'https://graph.facebook.com/me/feed', { :access_token => account.access_token, :message => message }
  end
  
  # show the user email in the admin UI instead of the user id
  def show_facebookurl_label_method
    "#{self.stream_url}"
  end
  
  #create a bitly link
  def self.shorten_link(link)
    #change user and api key to one for biemedia
    bitly = Bitly.new('hospitium','R_93a2ce1be0ecee1cc264afb2bac4381c')
    page_url = bitly.shorten(link)
    short_url = page_url.short_url
    #fall back to tinyurl if bitly fails
    if short_url.blank?
      short_url = RestClient.get "http://tinyurl.com/api-create.php?url=#{link}"
    end
    
    return short_url
  end

end

