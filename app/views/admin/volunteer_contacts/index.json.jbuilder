json.count @volunteer_contacts.count
json.page @volunteer_contacts.current_page
json.per_page @volunteer_contacts.per_page
json.pages_count @volunteer_contacts.total_pages
json.volunteer_contacts @volunteer_contacts do |contact|
  json.id contact.id
  json.first_name contact.first_name
  json.last_name contact.last_name
  json.address contact.address
  json.phone_number number_to_phone(contact.phone)
  json.email contact.email
  json.application_date contact.application_date
  json.created_at contact.created_at
  json.updated_at contact.updated_at
end