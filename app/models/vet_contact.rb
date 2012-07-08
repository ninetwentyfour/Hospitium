class VetContact < ActiveRecord::Base
  include CommonScopes
  
  belongs_to :organization
  before_create :create_uuid, :modify_phone_number
  before_update :modify_phone_number
  
  validates_presence_of :clinic_name
  
  attr_accessible :clinic_name, :address, :phone, :email, :website, :hours, :emergency
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  def show_name_label_method
    "#{self.clinic_name}"
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
  
  def as_xls(options = {})
    {
        "Id" => id.to_s,
        "Clinic Name" => clinic_name,
        "Address" => address,
        "Phone" => phone,
        "Email" => email,
        "Website" => website,
        "Hours" => hours,
        "Emergency" => emergency
    }
  end
  
end
