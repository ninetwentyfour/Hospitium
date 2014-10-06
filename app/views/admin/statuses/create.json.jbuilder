json.id @status.id
json.status @status.status
json.animals @animals do |animal|
  json.id animal.id
  json.name animal.name
end
json.created_at @status.created_at
json.updated_at @status.updated_at