json.id @shot.id
json.name @shot.name
json.last_administered @shot.last_administered
json.expires @shot.expires
json.animal do
  json.id @shot.animal.id
  json.name @shot.animal.name
end
json.created_at @shot.created_at
json.updated_at @shot.updated_at