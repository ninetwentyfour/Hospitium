json.count @presenter.adoption_contacts.count
json.page @presenter.adoption_contacts.current_page
json.per_page @presenter.adoption_contacts.per_page
json.pages_count @presenter.adoption_contacts.total_pages
json.adoption_contacts @presenter.adoption_contacts do |contact|
  json.id contact.id
  json.first_name contact.first_name
  json.last_name contact.last_name
  json.address contact.address
  json.phone_number number_to_phone(contact.phone)
  json.email contact.email
  json.created_at contact.created_at
  json.updated_at contact.updated_at
end