class WordpressAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  attr_accessible :site_url, :blog_user, :blog_password
  
  def self.post(message, account)
    begin
      require "xmlrpc/client"
      bloguser = account.blog_user
      blogpass = account.blog_password
      # Post Links To Blog Via XMLRPC
      account.site_url = account.site_url.gsub("http://", "") 
      account.site_url = account.site_url.gsub("https://", "") 
      server = XMLRPC::Client.new( "#{account.site_url}", "/xmlrpc.php")
      newPost = Hash.new
      newPost['title'] = "#{message['title']}"
      newPost['description'] = message['content']
      result = server.call("metaWeblog.newPost",1,bloguser,blogpass,newPost,true)

    rescue XMLRPC::FaultException => e
      puts "XMLRPC Error: "
      puts e.faultCode
      puts e.faultString
    rescue StandardError => e
      puts e.to_s
    end
  end
  
  # show the user email in the admin UI instead of the user id
  def show_wordpress_label_method
    "#{self.site_url}"
  end
  
  def self.new_by_user(params, current_user)    
    wordpress_account = self.new(params)
    wordpress_account.user_id = current_user.id
    wordpress_account.organization_id = current_user.organization_id
    wordpress_account.active = true
    wordpress_account.blog_password = SecPass::encrypt(wordpress_account.blog_password)
    wordpress_account
  end
  

end

