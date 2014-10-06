json.count @vet_contacts.count
json.page @vet_contacts.current_page
json.per_page @vet_contacts.per_page
json.pages_count @vet_contacts.total_pages
json.vet_contacts @vet_contacts do |contact|
  json.id contact.id
  json.clinic_name contact.clinic_name
  json.address contact.address
  json.phone number_to_phone(contact.phone)
  json.email contact.email
  json.created_at contact.created_at
  json.updated_at contact.updated_at
end