class Event < ActiveRecord::Base
  include CommonScopes
  
  belongs_to :animal
  
  attr_accessible :event_type, :event_message, :related_model_name, :related_model_id, :organization_id, :record_uuid
  
  after_create :increment_stats
  
  def increment_stats
    $statsd.increment 'event.created'
  end
end
