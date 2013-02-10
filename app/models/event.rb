class Event < ActiveRecord::Base
  include CommonScopes
  
  belongs_to :animal
  
  attr_accessible :event_type, :event_message, :related_model_name, :related_model_id, :organization_id, :record_uuid
  
  after_create :increment_stats
  
  def increment_stats
    $statsd.increment 'event.created'
  end
  
  # event_hash = {:type => "Event Type", :message => "Event Message", :organization => Current Obj Org ID, :uuid => "Record UUID", :animal => animal.id}
  def self.record_event(event_hash)
    @event = Event.new
    @event.animal_id = event_hash[:animal].to_i
    @event.update_attributes(:organization_id => event_hash[:organization].to_i,
      :event_type => "#{event_hash[:type]}", 
      :event_message => "#{event_hash[:message]}",
      :record_uuid => event_hash[:uuid],
      :related_model_id => event_hash.try(:[], :related_id),
      :related_model_name => event_hash.try(:[], :related_name)
      )
  end
  
end
