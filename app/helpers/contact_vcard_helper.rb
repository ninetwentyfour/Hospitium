module ContactVcardHelper
  def generate_vcard(contact)
    Vpim::Vcard::Maker.make2 do |maker|
      maker.add_name do |name|
        name.given = contact.first_name
        name.family = contact.last_name || ''
      end
      maker.add_addr do |addr|
        addr.preferred = true
        addr.location = 'home'
        addr.street = contact.address
      end unless contact.address.blank?
      maker.add_tel(contact.formatted_phone) unless contact.formatted_phone.blank?
      maker.add_email(contact.email) { |e| e.preferred = 'yes' } unless contact.email.blank?
    end
  end
end
