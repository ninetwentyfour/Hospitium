class WordpressAccount < ActiveRecord::Base
  belongs_to :user
  
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

end

