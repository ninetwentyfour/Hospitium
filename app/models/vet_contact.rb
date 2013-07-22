class VetContact < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include CommonScopes
  
  belongs_to :organization
  before_create :create_uuid, :modify_phone_number
  before_update :modify_phone_number

  attr_accessible :clinic_name, :address, :phone, :email, :website, :hours, :emergency
  
  validates_presence_of :clinic_name
  
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
    phone "Phone"
    email "Email"
    website "Website"
    hours "Hours"
    emergency "Emergency"
  end
end
