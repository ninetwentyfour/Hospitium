require 'octokit'

class HomeController < ApplicationController
  def index
    canonical_url('/')
  end
  
  def home
  end
  
  def about
    canonical_url('/about')
  end
  
  def features
    canonical_url('/features')
  end
  
  def privacy
    canonical_url('/privacy-and-terms-of-service')
  end
  
  def why
    canonical_url('/why-hospitium')
  end
  
  def changes
    canonical_url('/recent-changes')
    @recent_changes = Rails.cache.fetch('recent_changes_from_github', expires_in: 1.hour) do
      if ENV['HOSPITIUM_GITHUB_TOKEN']
        client = Octokit::Client.new(:access_token => ENV['HOSPITIUM_GITHUB_TOKEN'])
        client.list_commits('ninetwentyfour/Hospitium', branch = 'master', options = {}).map { |commit| {message: commit.commit.message, date: commit.commit.author.date, html_url: commit.html_url }}
      else
        Octokit.list_commits('ninetwentyfour/Hospitium', branch = 'master', options = {}).map { |commit| {message: commit.commit.message, date: commit.commit.author.date, html_url: commit.html_url}}
      end
    end
  end
end
