json.count @species.count
json.page @species.current_page
json.per_page @species.per_page
json.pages_count @species.total_pages
json.species @species do |species|
  json.id species.id
  json.name species.name
  json.created_at species.created_at
  json.updated_at species.updated_at
end