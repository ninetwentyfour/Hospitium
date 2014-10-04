class ApplicationController < ActionController::Base
  before_filter :check_domain
  before_filter :get_notice
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery # Turn on request forgery protection. Bear in mind that only non-GET, HTML/JavaScript requests are checked.
  ensure_security_headers
  
  
  #display notice on every admin page
  def get_notice
    @random_notice = Rails.cache.fetch('random_notifications', :expires_in => 1.minutes) do
      Notification.offset(rand(Notification.count)).select('notifications.message, notifications.status_type').first() unless Notification.count == 0
    end
  end
  
  # redirect to /admin after all logins
  def after_sign_in_path_for(resource_or_scope)
    '/admin'
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = "Default error message"
    redirect_to root_url, :notice => "That URL is prohibited"
  end
  
  rescue_from ActiveRecord::RecordNotFound do
    raise ActionController::RoutingError.new('Not Found')
  end

  # pretty sure this isnt used and can be removed
  APP_DOMAIN = 'hospitium.co'
  if Rails.env == "production"
    def ensure_domain
      if request.env['HTTP_HOST'] != APP_DOMAIN
        # HTTP 301 is a "permanent" redirect
        redirect_to "https://#{APP_DOMAIN}", :status => 301
      end
    end
  else
    def ensure_domain
      #do nothing
    end
  end
  
  def check_domain
    if Rails.env.production? and request.host.downcase != 'hospitium.co'
      redirect_to request.protocol + 'hospitium.co' + request.fullpath, :status => 301
    end
  end
  
  def canonical_url(canonical_url)
    @canonical_url = canonical_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:organization_name, :username, :email, :owner, :password, :password_confirmation) }
  end
end
