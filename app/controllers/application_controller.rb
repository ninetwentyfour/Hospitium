class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token
  before_filter :check_domain
  before_filter :get_notice
  before_filter :authenticate_user_from_token!, unless: :devise_controller?
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery # Turn on request forgery protection. Bear in mind that only non-GET, HTML/JavaScript requests are checked.
  ensure_security_headers
  
  
  #display notice on every admin page
  def get_notice
    @random_notice = Rails.cache.fetch('random_notifications', expires_in: 1.minutes) do
      Notification.offset(rand(Notification.count)).select('notifications.message, notifications.status_type').first() unless Notification.count == 0
    end
  end
  
  # redirect to /admin after all logins
  def after_sign_in_path_for(resource_or_scope)
    '/admin'
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = 'Default error message'
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'That URL is prohibited' }
      format.json { render status: 401,
                           json: {
                            success: false,
                            info: 'That URL is prohibited'
                           }}
    end
  end
  
  rescue_from ActiveRecord::RecordNotFound do
    raise ActionController::RoutingError.new('Not Found')
  end

  # pretty sure this isnt used and can be removed
  # APP_DOMAIN = 'hospitium.co'
  # if Rails.env == 'production'
  #   def ensure_domain
  #     if request.env['HTTP_HOST'] != APP_DOMAIN
  #       # HTTP 301 is a "permanent" redirect
  #       redirect_to "https://#{APP_DOMAIN}", status: 301
  #     end
  #   end
  # else
  #   def ensure_domain
  #     #do nothing
  #   end
  # end
  
  def check_domain
    if Rails.env.production? and request.host.downcase != 'hospitium.co'
      redirect_to request.protocol + 'hospitium.co' + request.fullpath, status: 301
    end
  end
  
  def canonical_url(canonical_url)
    @canonical_url = canonical_url
  end

  private

  def authenticate_user_from_token!
    if token_and_options(request)
      user_token = token_and_options(request).first
      user = Rails.cache.fetch("user_auth_#{user_token}", expires_in: 5.minutes) do
        user_token && User.where(authentication_token: user_token.to_s).first
      end
   
      if user
        # Notice we are passing store false, so the user is not
        # actually stored in the session and a token is needed
        # for every request. If you want the token to work as a
        # sign in token, you can simply remove store: false.
        sign_in user, store: false
      else
        # sleep 200-400ms
        sleep((200 + rand(200)) / 1000.0)
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:organization_name, :username, :email, :owner, :password, :password_confirmation) }
  end
end
