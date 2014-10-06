json.count @animal_colors.count
json.page @animal_colors.current_page
json.per_page @animal_colors.per_page
json.pages_count @animal_colors.total_pages
json.animal_colors @animal_colors do |color|
  json.id color.id
  json.color color.color
  json.created_at color.created_at
  json.updated_at color.updated_at
end