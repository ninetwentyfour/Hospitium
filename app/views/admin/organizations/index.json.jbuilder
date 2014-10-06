@organizations.each do |org|
  json.id org.id
  json.name org.name
  json.website org.website
  json.email org.email
  json.phone_number org.phone_number
  json.address org.address
  json.city org.city
  json.state org.state
  json.zip_code org.zip_code
  json.documents do
    json.adoption_form org.adoption_form.url
    json.volunteer_form org.volunteer_form.url
    json.relinquishment_form org.relinquishment_form.url
    json.foster_form org.foster_form.url
  end
end
