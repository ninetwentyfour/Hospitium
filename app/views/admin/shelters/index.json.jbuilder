json.count @shelters.count
json.page @shelters.current_page
json.per_page @shelters.per_page
json.pages_count @shelters.total_pages
json.shelters @shelters do |shelter|
  json.id shelter.id
  json.name shelter.name
  json.address shelter.address
  json.phone number_to_phone(shelter.phone)
  json.email shelter.email
  json.created_at shelter.created_at
  json.updated_at shelter.updated_at
end