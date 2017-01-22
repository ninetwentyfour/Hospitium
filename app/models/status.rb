class Status < ActiveRecord::Base
  include CommonScopes
  # include PublicActivity::Model
  # tracked owner: -> controller, model { controller.current_user },
  #         recipient: -> controller, model { controller.current_user.organization },
  #         params: {
  #           author_name: -> controller, model { controller.current_user.username },
  #           author_email: -> controller, model { controller.current_user.email },
  #           object_name: -> controller, model { model.status },
  #           summary: -> controller, model { model.changes }
  #         }

  belongs_to :organization
  has_many :animals

  attr_accessible :status

  validates :status, :organization_id, presence: true

  # show the link in the admin UI instead of the link id
  def show_status_label_method
    status
  end

  def report_display_name
    status
  end
end
