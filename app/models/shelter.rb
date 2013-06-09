class Shelter < ActiveRecord::Base
  include CommonScopes
  
  belongs_to :organization
  has_many :animals
  before_create :create_uuid, :modify_phone_number
  before_update :modify_phone_number
  validates_presence_of :name, :organization_id
  
  attr_accessible :name, :contact_first, :contact_last, :address, :phone, :email, :website, :notes
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
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
    name "Name"
    contact_first "Contact First Name"
    contact_last "Contact Last Name"
    address "Address"
    phone "Phone" do |p| number_to_phone(p) end
    email "Email"
    website "Website"
    notes "Notes"
  end
end
