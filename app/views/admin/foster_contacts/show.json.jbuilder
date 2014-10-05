contact = @foster_contact
json.id contact.id
json.first_name contact.first_name
json.last_name contact.last_name
json.address contact.address
json.phone_number number_to_phone(contact.phone)
json.email contact.email
json.created_at contact.created_at
json.updated_at contact.updated_at
json.animals @animals do |animal|
  json.id animal.id
  json.name animal.name
end