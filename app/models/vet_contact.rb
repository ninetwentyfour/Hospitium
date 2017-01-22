class VetContact < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include CommonScopes
  include PublicActivity::Model
  tracked owner: ->(controller, _model) { controller.current_user },
          recipient: ->(controller, _model) { controller.current_user.organization },
          params: {
            author_name: ->(controller, _model) { controller.current_user.username },
            author_email: ->(controller, _model) { controller.current_user.email },
            object_name: ->(_controller, model) { model.clinic_name },
            summary: ->(_controller, model) { model.changes }
          }

  belongs_to :organization
  before_create :modify_phone_number
  before_update :modify_phone_number

  attr_accessible :clinic_name, :address, :phone, :email, :website, :hours, :emergency

  validates :clinic_name, presence: true

  def show_name_label_method
    clinic_name
  end

  def modify_phone_number
    self.phone = phone.delete('^0-9') unless phone.blank?
  end

  def formatted_phone
    phone.blank? ? '' : number_to_phone(phone)
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
