class Admin::ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :ensure_domain
  before_filter :get_notice
  protect_from_forgery # Turn on request forgery protection. Bear in mind that only non-GET, HTML/JavaScript requests are checked.
  layout :set_layout
  
  #display notice on every admin page
  def get_notice
    require_dependency "Notification"
    @random_notice = Rails.cache.fetch('random_notifications', :expires_in => 1.minutes) do
      Notification.offset(rand(Notification.count)).first(:select => 'notifications.message, notifications.status_type') unless Notification.count == 0
    end
  end
  
  # redirect to /admin after all logins
  def after_sign_in_path_for(resource_or_scope)
    '/admin'
  end
  
  #rescue cancan permission errors
  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = "Default error message"
    redirect_to root_url, :notice => "That URL is prohibited"
  end
  
  #redirect to hospitium.com with 301 if hit heroku url
  APP_DOMAIN = 'hospitium.co'
  if Rails.env == "production"
    def ensure_domain
      if request.env['HTTP_HOST'] != APP_DOMAIN
        redirect_to "http://#{APP_DOMAIN}", :status => 301
      end
    end
  else
    def ensure_domain
      #do nothing - not in production
    end
  end
  
  #set canonical url for pages
  def canonical_url(canonical_url)
    @canonical_url = canonical_url
  end
  
  #read controller and action - used to set current page in nav
  def controller?(*controller)
    controller.include?(params[:controller])
  end
  def action?(*action)
    action.include?(params[:action])
  end

  #render the admin layout if not a pjax request
  private
    def set_layout
      if request.headers['X-PJAX']
        false
      else
        "admin/application"
      end
    end
end
