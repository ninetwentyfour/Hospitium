class VolunteerContact < ActiveRecord::Base
  include CommonScopes
  
  belongs_to :organization
  before_create :create_uuid, :modify_phone_number
  before_update :modify_phone_number
  
  validates_presence_of :first_name, :last_name, :address, :organization_id
  
  attr_accessible :first_name, :last_name, :address, :phone, :email, :application_date
  
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  def show_name_label_method
    "#{self.first_name} #{self.last_name}"
  end
  
  def modify_phone_number
    unless self.phone.blank?
      self.phone = self.phone.delete("^0-9")
    end
  end
  
  def formatted_phone
    unless self.phone.blank?
      phone = number_to_phone(self.phone)
    else
      phone = ""
    end
    return phone
  end
  
  def formatted_application_date
    unless self.application_date.blank?
      age = self.application_date.strftime("%a, %b %e at %l:%M")
    else
      age = ""
    end
    return age
  end
  
  def as_xls(options = {})
    {
        "Id" => id.to_s,
        "First Name" => first_name,
        "Last Name" => last_name,
        "Address" => address,
        "Phone" => phone,
        "Email" => email,
        "Application Date" => application_date
    }
  end
  
end