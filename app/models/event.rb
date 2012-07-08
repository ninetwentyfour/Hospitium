class Event < ActiveRecord::Base
  include CommonScopes
  
  belongs_to :animal
  
  attr_accessible :event_type, :event_message, :related_model_name, :related_model_id, :organization_id, :record_uuid
end
