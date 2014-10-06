json.id @animal.id
json.name @animal.name
json.species @animal.species_name
json.status @animal.try(:status).try(:status)
json.sex @animal.sex unless @animal.animal_sex.blank?
json.age calculate_animal_age(@animal.birthday) unless @animal.birthday.blank?
json.spay_neuter @animal.spay unless @animal.spay_neuter.blank?
json.biter @animal.biter.value
json.special_needs @animal.special_needs
json.color @animal.color
json.microchip @animal.microchip
json.shelter @animal.shelter_name
json.diet @animal.diet
json.previous_name @animal.previous_name
json.date_of_intake @animal.date_of_intake
json.date_of_well_check @animal.date_of_well_check
json.adopted_date @animal.adopted_date
json.deceased @animal.deceased
json.deceased_reason @animal.deceased_reason
json.image_1 @animal.image.url(:medium)
json.image_2 @animal.second_image.url(:medium)
json.image_3 @animal.third_image.url(:medium)
json.image_4 @animal.fourth_image.url(:medium)
json.created_at @animal.created_at
json.updated_at @animal.updated_at
