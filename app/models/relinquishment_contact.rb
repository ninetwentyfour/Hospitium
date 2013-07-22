class RelinquishmentContact < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include CommonScopes
  
  has_many :relinquish_animals
  has_many :animals, :through => :relinquish_animals
  belongs_to :organization
  before_create :create_uuid, :modify_phone_number
  before_update :modify_phone_number

  attr_accessible :first_name, :last_name, :address, :phone, :email, :reason
  
  validates_presence_of :first_name, :last_name, :organization_id
  
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
    reason "Reason"
    animals "Relinquished Animal IDs" do |a| a.map{|a| a.id}.join(",") end
  end
  
end
