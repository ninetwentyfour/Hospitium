class VetContact < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include CommonScopes
  include PublicActivity::Model
  tracked owner: -> controller, model { controller.current_user }, 
          recipient: -> controller, model { controller.current_user.organization }, 
          params: {
            author_name: -> controller, model { controller.current_user.username },
            author_email: -> controller, model { controller.current_user.email },
            object_name: -> controller, model { model.clinic_name },
            summary: -> controller, model { model.changes }
          }
  
  belongs_to :organization
  before_create :modify_phone_number
  before_update :modify_phone_number

  attr_accessible :clinic_name, :address, :phone, :email, :website, :hours, :emergency
  
  validates_presence_of :clinic_name
  
  def show_name_label_method
    self.clinic_name
  end
  
  def modify_phone_number
    self.phone = self.phone.delete('^0-9') unless self.phone.blank?
  end
  
  def formatted_phone
    self.phone.blank? ? '' : number_to_phone(self.phone)
  end
  
  # ===============
  # = CSV support =
  # ===============
  comma do
    id 'ID'
    clinic_name 'Clinic Name'
    address 'Address'
    phone 'Phone'
    email 'Email'
    website 'Website'
    hours 'Hours'
    emergency 'Emergency'
  end
end
