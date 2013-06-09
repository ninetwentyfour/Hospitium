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
  
  # ===============
  # = CSV support =
  # ===============
  comma do
    id "ID"
    clinic_name "Clinic Name"
    address "Address"
    phone "Phone" do |p| number_to_phone(p) end
    email "Email"
    website "Website"
    hours "Hours"
    emergency "Emergency"
  end
end
