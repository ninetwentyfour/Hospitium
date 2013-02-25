class ShortLink
  
  def self.shorten_link(link)
    Bitly.use_api_version_3
    bitly = Bitly.new('hospitium',ENV['BITLY_API'])
    page_url = bitly.shorten(link)
    short_url = page_url.short_url
    #fall back to tinyurl if bitly fails
    if short_url.blank?
      short_url = RestClient.get "https://tinyurl.com/api-create.php?url=#{link}"
    end
    
    short_url
  end
  
end