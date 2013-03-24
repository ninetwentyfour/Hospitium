class WordpressAccountsController < ApplicationController

  def create
    @wordpress_account = WordpressAccount.new_by_user(params[:wordpress_account], current_user)
    if @wordpress_account.save
      flash[:notice] = 'Wordpress Account Connected!'
    else
      flash[:error] = 'Wordpress Account Was Not Connected!'
    end
    
    redirect_to "#{root_url}admin/users/#{current_user.id}"
  end
  
  def update
    @wordpress = WordpressAccount.find(params[:id])
    if params[:wordpress_account]["blog_password"]
      params[:wordpress_account]["blog_password"] = SecPass::encrypt(params[:wordpress_account]["blog_password"])
    end
    respond_to do |format|
      if  @wordpress.update_attributes(params[:wordpress_account])
        format.html {redirect_to("#{root_url}admin/users/#{current_user.id}", :notice => 'Wordpress Account Updated!')}
      else
        format.html { render "new" }
      end
    end
  end
  
  
  def send_blog_post
    account = WordpressAccount.find_by_user_id(current_user.id)
    if account.blank?
      redirect_to("#{root_url}admin/user/#{current_user.id}", :notice => 'Please Add Wordpress Credentials!')
    else
      account.blog_password = SecPass::decrypt(account.blog_password)
      link = ShortLink.shorten_link("#{root_url}animals/#{params[:animal_uuid]}")
      message = Hash.new
      message['title'] = "#{params[:animal_name]} is ready for adoption!"
      
      message['content'] = "<p><img src='#{params[:animal_picture]}' /></p>
      <p>#{params[:animal_name]} is ready for adoption at <a href='#{link}'>#{link}</a> via <a href='https://twitter.com/hospitium_app'>@hospitium_app</a>.</p>"
      
      WordpressAccount.post(message, account)
      redirect_to("#{root_url}admin/animals/#{params[:animal_id]}-#{params[:animal_uuid]}", :notice => 'Wordpress Post Sent', :only_path => true)
    end
  end
  
  
  def destroy
    @wordpress = WordpressAccount.find(params[:id])
    @wordpress.destroy

    respond_to do |format|
      format.html {redirect_to("#{root_url}admin/users/#{current_user.id}", :notice => 'Wordpress Account deleted!')}
      format.xml  { head :ok }
    end
  end

end

