class AdoptionContact < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include CommonScopes
  
  has_many :adopt_animals
  has_many :animals, :through => :adopt_animals
  belongs_to :organization
  before_create :create_uuid, :modify_phone_number
  before_update :modify_phone_number

  attr_accessible :first_name, :last_name, :address, :phone, :email, :adopted_date
  
  validates_presence_of :first_name, :last_name, :address, :organization_id
  
  accepts_nested_attributes_for :adopt_animals
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  #remove all characters from phone number except digits
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
    first_name "First Name"
    last_name "Last Name"
    address "Address"
    phone "Phone"
    email "Email"
    animals "Adopted Animal IDs" do |a| a.map{|a| a.id}.join(",") end
  end
  
end
