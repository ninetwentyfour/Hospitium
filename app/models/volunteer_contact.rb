class VolunteerContact < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include CommonScopes
  include PublicActivity::Model
  tracked owner: ->(controller, _model) { controller.current_user },
          recipient: ->(controller, _model) { controller.current_user.organization },
          params: {
            author_name: ->(controller, _model) { controller.current_user.username },
            author_email: ->(controller, _model) { controller.current_user.email },
            object_name: ->(_controller, model) { "#{model.first_name} #{model.last_name}" },
            summary: ->(_controller, model) { model.changes }
          }

  belongs_to :organization
  has_many :documents, as: :documentable

  before_create :modify_phone_number
  before_update :modify_phone_number

  attr_accessible :first_name, :last_name, :address, :phone, :email, :application_date

  validates :first_name, :last_name, :address, :organization_id, presence: true

  def show_name_label_method
    "#{first_name} #{last_name}"
  end

  def modify_phone_number
    self.phone = phone.delete('^0-9') unless phone.blank?
  end

  def formatted_phone
    phone.blank? ? '' : number_to_phone(phone)
  end

  def formatted_application_date
    application_date.blank? ? '' : application_date.strftime('%a, %b %e at %l:%M')
  end

  # ===============
  # = CSV support =
  # ===============
  comma do
    id 'ID'
    first_name 'First Name'
    last_name 'Last Name'
    address 'Address'
    phone 'Phone'
    email 'Email'
    application_date 'Application Date'
  end
end
