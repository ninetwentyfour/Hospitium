class FacebookAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  attr_accessible :user_id

  # Get these from facebook!
  FACEBOOK_CLIENT_ID = ENV['FACEBOOK_CLIENT_ID']
  FACEBOOK_CLIENT_SECRET = ENV['FACEBOOK_CLIENT_SECRET']

  def authorize_url(callback_url = '')
    if oauth_authorize_url.blank?
      self.oauth_authorize_url = "https://graph.facebook.com/oauth/authorize?client_id=#{FACEBOOK_CLIENT_ID}&redirect_uri=#{callback_url}&scope=offline_access,publish_stream"
      save!
    end
    oauth_authorize_url
  end

  def validate_oauth_token(oauth_verifier, callback_url = '')
    response = RestClient.get 'https://graph.facebook.com/oauth/access_token', params: {
      client_id: FACEBOOK_CLIENT_ID,
      redirect_uri: callback_url.html_safe.to_s,
      client_secret: FACEBOOK_CLIENT_SECRET,
      code: oauth_verifier.html_safe.to_s
    }
    pair = response.body.split('&')[0].split('=')
    if pair[0] == 'access_token'
      self.access_token = pair[1]
      response = RestClient.get 'https://graph.facebook.com/me', params: { access_token: access_token }
      self.stream_url = JSON.parse(response.body)['link']
      self.active = true
    else
      errors.add(:oauth_verifier, "Invalid token, unable to connect to facebook: #{pair[1]}")
      self.active = false
    end
    # self.user_id = current_user.id
    save!
  end

  def self.post(message, user)
    account = FacebookAccount.find_by(user_id: user)
    RestClient.post 'https://graph.facebook.com/me/feed', access_token: account.access_token, message: message
  end

  # show the user email in the admin UI instead of the user id
  def show_facebookurl_label_method
    stream_url.to_s
  end
end
