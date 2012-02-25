class WordpressAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  
  
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
    bitly = Bitly.new('hospitium','R_93a2ce1be0ecee1cc264afb2bac4381c')
    page_url = bitly.shorten(link)
    short_url = page_url.short_url
    #fall back to tinyurl if bitly fails
    if short_url.blank?
      short_url = RestClient.get "http://tinyurl.com/api-create.php?url=#{link}"
    end
    
    return short_url
  end

end

