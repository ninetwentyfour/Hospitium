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
  
  validates_presence_of :name, :organization_id
  
  def report_display_name
    self.name
  end
end
