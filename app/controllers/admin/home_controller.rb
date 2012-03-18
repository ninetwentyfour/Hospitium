class Admin::HomeController < Admin::ApplicationController

  def index
    #generate the animal percentages for the dashboard
    @animals_count = Animal.count(:conditions => {:organization_id => current_user.organization_id}) 
    @animal_update = Animal.order("updated_at desc").first(:conditions => {:organization_id => current_user.organization_id}).try(:updated_at)
    @final_status_hash = Rails.cache.fetch("animal_status_hash_user_#{current_user.organization_id}_#{@animals_count}_#{@animal_update}") do
      Report.animals_by_status(current_user.organization_id)
    end
    @final_species_hash = Rails.cache.fetch("animal_species_hash_user_#{current_user.organization_id}_#{@animals_count}_#{@animal_update}") do
      Report.animals_by_species(current_user.organization_id)
    end
    
    #get twitter feed for users twitter account if one exists
    #require_dependency "TwitterAccount"
    #twitter = Rails.cache.fetch("twitter_account_user_#{current_user.id}", :expires_in => 35.minutes) do
       twitter = TwitterAccount.find(:first, :select => 'twitter_accounts.oauth_token, twitter_accounts.oauth_token_secret', :conditions => {:user_id => current_user.id})
    #end
    unless twitter.blank?
      Twitter.configure do |config|
        config.consumer_key = 'Is9pdOhRRNhx95wGBiWg'
        config.consumer_secret = 'D2WLDX0Fh9EOGAhBJSQFkKs1U2c3ET2a5z2t9JZCrM'
        config.oauth_token = twitter.oauth_token
        config.oauth_token_secret = twitter.oauth_token_secret
      end
      @tweets = Rails.cache.fetch("tweets_listing_user_#{current_user.id}", :expires_in => 5.minutes) do
         #Twitter.home_timeline(:count => 10)
      end
      #@tweets = Twitter.home_timeline(:count => 10)
    else
      #do nothing
      @tweets = ''
    end
  end
  
end
