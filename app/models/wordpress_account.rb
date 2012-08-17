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
  
  #create a bitly link
  def self.shorten_link(link)
    #change user and api key to one for biemedia
    bitly = Bitly.new('hospitium',ENV['BITLY_API'])
    page_url = bitly.shorten(link)
    short_url = page_url.short_url
    #fall back to tinyurl if bitly fails
    if short_url.blank?
      short_url = RestClient.get "https://tinyurl.com/api-create.php?url=#{link}"
    end
    
    return short_url
  end
  
  def self.new_by_user(params, current_user)    
    wordpress_account = self.new(params)
    wordpress_account.user_id = current_user.id
    wordpress_account.organization_id = current_user.organization_id
    wordpress_account.active = true
    wordpress_account.blog_password = Base64.encode64(Encryptor.encrypt(:value => "#{wordpress_account.blog_password}", :key => ENV['SALTY']).force_encoding('UTF-8')).encode('utf-8')
    wordpress_account
  end
  

end

