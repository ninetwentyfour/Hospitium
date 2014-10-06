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
json.notes @presenter.notes do |note|
  json.id note.id
  json.created_by note.username
  json.note note.note
  json.created_at note.created_at
end
json.documents @presenter.documents do |document|
  json.id document.id
  json.file_name document.document_file_name
  json.url document.document.url
  json.created_at document.created_at
end
json.shots @presenter.shots do |shot|
  json.id shot.id
  json.name shot.name
  json.last_administered shot.last_administered
  json.expires shot.expires
  json.created_at shot.created_at
end
cnt = 0
json.weights @presenter.animal_weights[:values].each_with_index do |value, index|
    json.weight value
    json.date_of_weight @presenter.animal_weights[:times][cnt]
    cnt+=1
end

json.image_1 @animal.image.url(:medium)
json.image_2 @animal.second_image.url(:medium)
json.image_3 @animal.third_image.url(:medium)
json.image_4 @animal.fourth_image.url(:medium)
json.created_at @animal.created_at
json.updated_at @animal.updated_at
