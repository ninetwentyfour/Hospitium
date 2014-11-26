class AnimalColor < ActiveRecord::Base
  include CommonScopes
  # include PublicActivity::Model
  # tracked owner: -> controller, model { controller.current_user }, 
  #         recipient: -> controller, model { controller.current_user.organization }, 
  #         params: {
  #           author_name: -> controller, model { controller.current_user.username },
  #           author_email: -> controller, model { controller.current_user.email },
  #           object_name: -> controller, model { model.color },
  #           summary: -> controller, model { model.changes }
  #         }

  belongs_to :organization
  has_many :animals

  attr_accessible :color
  
  validates_presence_of :color, :organization_id
  
  def report_display_name
    self.color
  end
end
