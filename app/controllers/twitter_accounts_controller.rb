class TwitterAccountsController < ApplicationController
  
  def new
    twitter_account = TwitterAccount.create(:user => current_user)
    redirect_to(twitter_account.authorize_url(twitter_callback_url))
  end
  
  def callback
    if params[:denied] && !params[:denied].empty?
      redirect_to(deals_url, :alert => 'Unable to connect with twitter: #{parms[:denied]}')
    else
      twitter_account = TwitterAccount.find_by_oauth_token(params[:oauth_token])
      twitter_account.validate_oauth_token(params[:oauth_verifier], twitter_callback_url)
      twitter_account.save
      if twitter_account.active?
        redirect_to(deals_url, :notice => 'Twitter account activated!')
      else
        redirect_to(deals_url, :notice => "Unable to activate twitter account.")
      end
    end
  end
  
  def show
    #puts debug(current_user.id)
    TwitterAccount.twitter_post("#{params[:animal_name]} is ready for adoption at http://hospitium.heroku.com/animals/#{params[:animal_uuid]}", params[:twitter_user_id])
    #TwitterAccount.twitter_post("test is ready for adoption at http://hospitium.heroku.com/animals/test", 1)
    redirect_to :back
  end
 
end