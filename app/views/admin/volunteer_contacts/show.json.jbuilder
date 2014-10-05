contact = @volunteer_contact
json.id contact.id
json.first_name contact.first_name
json.last_name contact.last_name
json.address contact.address
json.phone_number number_to_phone(contact.phone)
json.email contact.email
json.application_date contact.application_date
json.created_at contact.created_at
json.updated_at contact.updated_at