include ActionView::Helpers::NumberHelper
class AdoptionContact < ActiveRecord::Base
  has_paper_trail
  has_many :adopt_animals
  has_many :animals, :through => :adopt_animals
  belongs_to :organization
  before_create :create_uuid, :modify_phone_number
  before_update :modify_phone_number
  
  validates_presence_of :first_name, :last_name, :address
  
  accepts_nested_attributes_for :adopt_animals
  
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
  
end
