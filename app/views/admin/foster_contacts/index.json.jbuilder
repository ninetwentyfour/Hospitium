json.count @presenter.foster_contacts.count
json.page @presenter.foster_contacts.current_page
json.per_page @presenter.foster_contacts.per_page
json.pages_count @presenter.foster_contacts.total_pages
json.foster_contacts @presenter.foster_contacts do |contact|
  json.id contact.id
  json.first_name contact.first_name
  json.last_name contact.last_name
  json.address contact.address
  json.phone_number number_to_phone(contact.phone)
  json.email contact.email
  json.created_at contact.created_at
  json.updated_at contact.updated_at
end