class WordpressAccountsController < ApplicationController

  def create
    @wordpress_account = WordpressAccount.new(params[:wordpress_account])
    @wordpress_account.user_id = current_user.id
    @wordpress_account.organization_id = current_user.organization_id
    @wordpress_account.active = true
    @wordpress_account.blog_password = Base64.encode64("#{@wordpress_account.blog_password}~#{current_user.username}")
    respond_to do |format|
      if  @wordpress_account.save
        format.html {redirect_to("#{root_url}admin/users/#{current_user.id}", :notice => 'Wordpress Account Connected!')}
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @wordpress = WordpressAccount.find(params[:id])
    params[:wordpress_account]["blog_password"] = Base64.encode64("#{params[:wordpress_account]["blog_password"]}~#{current_user.username}")
    respond_to do |format|
      if  @wordpress.update_attributes(params[:wordpress_account])
        format.html {redirect_to("#{root_url}admin/users/#{current_user.id}", :notice => 'Wordpress Account Connected!')}
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  
  def send_blog_post
    account = WordpressAccount.find_by_user_id(current_user.id)
    account.blog_password = Base64.decode64(account.blog_password).split("~").first
    if account.blank?
      redirect_to("#{root_url}admin/user/#{current_user.id}", :notice => 'Please Add Wordpress Credentials!')
    else
      link = WordpressAccount.shorten_link("#{root_url}animals/#{params[:animal_uuid]}")
      message = Hash.new
      message['title'] = "#{params[:animal_name]} is ready for adoption!"
      
      message['content'] = "<p><img src='#{params[:animal_picture]}' /></p>
      <p>#{params[:animal_name]} is ready for adoption at <a href='#{link}'>#{link}</a> via <a href='http://twitter.com/#!/hospitium_app'>@hospitium_app</a>.</p>"
      
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

