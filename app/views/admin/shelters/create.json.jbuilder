json.id @shelter.id
json.name @shelter.name
json.first_name @shelter.contact_first
json.last_name @shelter.contact_last
json.website @shelter.website
json.address @shelter.address
json.phone number_to_phone(@shelter.phone)
json.email @shelter.email
json.notes @shelter.notes
json.animals @shelter.animals do |animal|
  json.id animal.id
  json.name animal.name
end
json.created_at @shelter.created_at
json.updated_at @shelter.updated_at