class VolunteerContact < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include CommonScopes
  include PublicActivity::Model
  tracked owner: -> controller, model { controller.current_user }, 
          recipient: -> controller, model { controller.current_user.organization }, 
          params: {
            author_name: -> controller, model { controller.current_user.username },
            author_email: -> controller, model { controller.current_user.email },
            object_name: -> controller, model { "#{model.first_name} #{model.last_name}" },
            summary: -> controller, model { model.changes }
          }
  
  belongs_to :organization
  has_many :documents, :as => :documentable
  
  before_create :modify_phone_number
  before_update :modify_phone_number

  attr_accessible :first_name, :last_name, :address, :phone, :email, :application_date
  
  validates_presence_of :first_name, :last_name, :address, :organization_id
  
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
    phone "Phone"
    email "Email"
    application_date "Application Date"
  end
end