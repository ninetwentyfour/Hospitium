json.id @species.id
json.name @species.name
json.animals @animals do |animal|
  json.id animal.id
  json.name animal.name
end
json.created_at @species.created_at
json.updated_at @species.updated_at