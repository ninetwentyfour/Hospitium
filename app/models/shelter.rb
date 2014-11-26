class Shelter < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include CommonScopes
  include PublicActivity::Model
  tracked owner: -> controller, model { controller.current_user }, 
          recipient: -> controller, model { controller.current_user.organization }, 
          params: {
            author_name: -> controller, model { controller.current_user.username },
            author_email: -> controller, model { controller.current_user.email },
            object_name: -> controller, model { model.name },
            summary: -> controller, model { model.changes }
          }
  
  belongs_to :organization
  has_many :animals
  before_create :modify_phone_number
  before_update :modify_phone_number

  attr_accessible :name, :contact_first, :contact_last, :address, :phone, :email, :website, :notes

  validates_presence_of :name, :organization_id
  
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
    name 'Name'
    contact_first 'Contact First Name'
    contact_last 'Contact Last Name'
    address 'Address'
    phone 'Phone'
    email 'Email'
    website 'Website'
    notes 'Notes'
  end
end
