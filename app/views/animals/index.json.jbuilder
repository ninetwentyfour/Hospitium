json.count @animals.count
json.page @animals.current_page
json.per_page @animals.per_page
json.pages_count @animals.total_pages
json.animals @animals do |animal|
  json.id animal.id
  json.name animal.name
  json.location animal.organization.full_address
  json.status animal.status.status
  json.species_name animal.species_name
  json.sex animal.sex
  json.age calculate_animal_age(animal.birthday) unless animal.birthday.blank?
  json.spay_neuter animal.spay
  json.color animal.color
  json.special_needs animal.special_needs
  json.organization animal.organization_name
  json.image_1 animal.image.url(:medium)
  json.image_2 animal.second_image.url(:medium)
  json.image_3 animal.third_image.url(:medium)
  json.image_4 animal.fourth_image.url(:medium)
end
