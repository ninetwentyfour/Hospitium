class AnimalEvent < ActiveRecord::Base
  belongs_to :animal
  
  attr_accessible :event_type, :event_message, :related_model_name, :related_model_id
end
