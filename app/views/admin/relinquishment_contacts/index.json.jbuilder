json.count @relinquishment_contacts.count
json.page @relinquishment_contacts.current_page
json.per_page @relinquishment_contacts.per_page
json.pages_count @relinquishment_contacts.total_pages
json.relinquishment_contacts @relinquishment_contacts do |contact|
  json.id contact.id
  json.first_name contact.first_name
  json.last_name contact.last_name
  json.address contact.address
  json.phone_number number_to_phone(contact.phone)
  json.email contact.email
  json.reason contact.reason
  json.created_at contact.created_at
  json.updated_at contact.updated_at
end