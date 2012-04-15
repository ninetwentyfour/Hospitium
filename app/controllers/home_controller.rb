class HomeController < ApplicationController
  #caches_action :index, :expires_in => 1.hour
  def index
    canonical_url("/")
  end
  
  def home
  end
  
  def about
    canonical_url("/about")
  end
  
  def features
    canonical_url("/features")
  end
  
  def privacy
    canonical_url("/privacy-and-terms-of-service")
  end
  
  def why
    canonical_url("/why-hospitium")
  end
  
  def changes
    canonical_url("/recent-changes")
    require_dependency 'Hashie'
    @commits = Rails.cache.fetch('recent_app_changes', :expires_in => 180.minutes) do
      Octokit.commits("ninetwentyfour/Hospitium", branch = "master", options = {})
    end
    #@commits = Octokit.commits("ninetwentyfour/Hospitium", branch = "master", options = {})
  end

end