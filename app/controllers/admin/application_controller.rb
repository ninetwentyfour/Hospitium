class Admin::ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :ensure_domain
  before_filter :get_notice
  protect_from_forgery # Turn on request forgery protection. Bear in mind that only non-GET, HTML/JavaScript requests are checked.
  
  
  def get_notice
    require_dependency "Notification"
    @random_notice = Rails.cache.fetch('random_notifications', :expires_in => 1.minutes) do
      Notification.offset(rand(Notification.count)).first(:select => 'notifications.message, notifications.status_type')
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

  APP_DOMAIN = 'hospitium.co'

  if Rails.env == "production"
    def ensure_domain
      if request.env['HTTP_HOST'] != APP_DOMAIN
        # HTTP 301 is a "permanent" redirect
        redirect_to "http://#{APP_DOMAIN}", :status => 301
      end
    end
  else
    def ensure_domain
      #do nothing
    end
  end
  
  def canonical_url(canonical_url)
    @canonical_url = canonical_url
  end
  
  layout :set_layout

  private
    def set_layout
      if request.headers['X-PJAX']
        false
      else
        "admin/application"
      end
    end
end
