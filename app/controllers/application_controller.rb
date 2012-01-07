class ApplicationController < ActionController::Base
  before_filter :ensure_domain
  protect_from_forgery # Turn on request forgery protection. Bear in mind that only non-GET, HTML/JavaScript requests are checked.
  
  # redirect to /admin after all logins
  def after_sign_in_path_for(resource_or_scope)
    '/admin'
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = "Default error message"
    redirect_to root_url, :notice => "That URL is prohibited"
  end

  APP_DOMAIN = 'hospitium.co'

  if RAILS_ENV == "production"
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
  
  protected 
    def render_optional_error_file(status_code) 
      #render :template => "errors/500", :status => 500, :layout => 'application'
      status = interpret_status(status_code)[0,3]
      if ["404"].include?(status)
        render :template => "/errors/404.html.erb", :status => status, :layout => 'application'
      else
        render :template => "/errors/500.html.erb", :status => status, :layout => 'application'
      end
  end
end
