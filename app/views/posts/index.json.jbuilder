json.count @posts.count
json.page @posts.current_page
json.per_page @posts.per_page
json.pages_count @posts.total_pages
json.posts @posts do |post|
  json.id post.id
  json.title post.title
  json.slug post.slug
  json.content "#{markdown(truncate(post.content, :length => 140))} #{link_to 'Read More', post_path(post)}"
end
