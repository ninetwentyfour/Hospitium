class VolunteerContact < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include CommonScopes
  
  belongs_to :organization
  has_many :documents, :as => :documentable
  
  before_create :create_uuid, :modify_phone_number
  before_update :modify_phone_number

  attr_accessible :first_name, :last_name, :address, :phone, :email, :application_date
  
  validates_presence_of :first_name, :last_name, :address, :organization_id
    
  
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
  
  # ===============
  # = CSV support =
  # ===============
  comma do
    id "ID"
    first_name "First Name"
    last_name "Last Name"
    address "Address"
    phone "Phone" do |p| formatted_phone end
    email "Email"
    application_date "Application Date"
  end
end