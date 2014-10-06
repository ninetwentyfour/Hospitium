json.id @animal_color.id
json.color @animal_color.color
json.created_at @animal_color.created_at
json.updated_at @animal_color.updated_at
json.animals @animals do |animal|
  json.id animal.id
  json.name animal.name
end