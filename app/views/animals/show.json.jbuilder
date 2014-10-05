json.id @animal.id
json.name @animal.name
json.status @animal.status.status
json.species @animal.species_name
json.sex @animal.sex unless @animal.animal_sex.blank?
json.age calculate_animal_age(@animal.birthday) unless @animal.birthday.blank?
json.spay_neuter @animal.spay unless @animal.spay_neuter.blank?
json.color @animal.color
json.special_needs @animal.special_needs
json.image_1 @animal.image.url(:medium)
json.image_2 @animal.second_image.url(:medium)
json.image_3 @animal.third_image.url(:medium)
json.image_4 @animal.fourth_image.url(:medium)
json.organization do
  json.name @animal.organization_name
  json.email @animal.organization_email
  json.website @animal.organization.pretty_website
  json.phone_number number_to_phone(@animal.organization_phone_number, :area_code => true)
  json.address @animal.organization.full_address
end