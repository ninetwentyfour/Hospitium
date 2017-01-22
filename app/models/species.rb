class Species < ActiveRecord::Base
  include CommonScopes
  # include PublicActivity::Model
  # tracked owner: -> controller, model { controller.current_user },
  #         recipient: -> controller, model { controller.current_user.organization },
  #         params: {
  #           author_name: -> controller, model { controller.current_user.username },
  #           author_email: -> controller, model { controller.current_user.email },
  #           object_name: -> controller, model { model.name },
  #           summary: -> controller, model { model.changes }
  #         }

  belongs_to :organization
  has_many :animals

  attr_accessible :name

  validates :name, :organization_id, presence: true

  def report_display_name
    name
  end
end
