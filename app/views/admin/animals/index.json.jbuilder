json.count @animals.count
json.page @animals.current_page
json.per_page @animals.per_page
json.pages_count @animals.total_pages
json.animals @animals do |animal|
  json.id animal.id
  json.name animal.name
  json.species animal.species_name
  json.status animal.try(:status).try(:status)
  json.sex animal.sex unless animal.animal_sex.blank?
  json.age calculate_animal_age(animal.birthday) unless animal.birthday.blank?
  json.spay_neuter animal.spay unless animal.spay_neuter.blank?
  json.color animal.color
  json.created_at animal.created_at
  json.updated_at animal.updated_at
end
