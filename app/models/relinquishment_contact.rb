class RelinquishmentContact < ActiveRecord::Base
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

  has_many :relinquish_animals
  has_many :animals, through: :relinquish_animals
  belongs_to :organization
  before_create :modify_phone_number
  before_update :modify_phone_number

  attr_accessible :first_name, :last_name, :address, :phone, :email, :reason

  validates :first_name, :last_name, :organization_id, presence: true

  def show_name_label_method
    "#{first_name} #{last_name}"
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
    first_name 'First Name'
    last_name 'Last Name'
    address 'Address'
    phone 'Phone'
    email 'Email'
    reason 'Reason'
    animals 'Relinquished Animal IDs' do |a| a.map(&:id).join(',') end
  end
end
