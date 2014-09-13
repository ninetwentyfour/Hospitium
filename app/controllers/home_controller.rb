require 'octokit'

class HomeController < ApplicationController
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
    @recent_changes = Rails.cache.fetch("recent_changes_from_github", :expires_in => 1.hour) do
      Octokit.list_commits("ninetwentyfour/Hospitium", branch = "master", options = {}).map { |commit| {message: commit.commit.message, date: commit.commit.author.date }}
    end
  end

end