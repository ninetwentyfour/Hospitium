json.id @organization.id
json.name @organization.name
json.email @organization.email
json.website @organization.pretty_website
json.phone_number number_to_phone(@organization.phone_number, :area_code => true)
json.address @organization.full_address