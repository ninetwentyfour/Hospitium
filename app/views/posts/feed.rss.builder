xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Hospitium - Animal Management Software"
    xml.description "Keeping track of animals shouldn't be a pain."
    xml.link posts_url

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.content
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link "http://hospitium.co/posts/#{post.id}-#{post.title.parameterize}"
        xml.guid "http://hospitium.co/posts/#{post.id}-#{post.title.parameterize}"
      end
    end
  end
end