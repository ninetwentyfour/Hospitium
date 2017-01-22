class FacebookAccountsController < ApplicationController
  def new
    facebook_account = FacebookAccount.create(user: current_user)
    redirect_to(facebook_account.authorize_url(facebook_callback_url(id: facebook_account.id)))
  end

  def callback
    if params[:error_reason] && !params[:error_reason].empty?
      # We have a problem!
      redirect_to(:root, notice: "Unable to activate facebook: #{params[:error_reason]}")
    elsif params[:code] && !params[:code].empty?
      # This is the callback, we have an id and an access code
      facebook_account = FacebookAccount.find(params[:id])
      facebook_account.validate_oauth_token(params[:code], facebook_callback_url(id: facebook_account.id))
      redirect_to("#{root_url}admin/users/#{current_user.id}", notice: 'Facebook account activated! You will need to resend the last post.')
    end
  end

  def send_wall_post
    account = FacebookAccount.find_by(user_id: current_user.id)
    if account.blank?
      facebook_account = FacebookAccount.create(user_id: current_user.id)
      redirect_to(facebook_account.authorize_url(facebook_callback_url(id: facebook_account.id)))
    else
      link = ShortLink.shorten_link("#{root_url}animals/#{params[:animal_uuid]}")
      FacebookAccount.post("#{params[:animal_name]} is ready for adoption at #{link} via @hospitium_app.", current_user.id)
      redirect_to("#{root_url}admin/animals/#{params[:animal_id]}-#{params[:animal_uuid]}", notice: 'Facebook Post Sent')
    end
  end

  def destroy
    @account = FacebookAccount.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to("#{root_url}admin/users/#{current_user.id}", notice: 'Facebook Account destroyed!') }
      format.xml  { head :ok }
    end
  end
end
