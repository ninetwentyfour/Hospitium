class DocumentObserver < ActiveRecord::Observer
  
  def after_create(document)
      record_event(document)
  end
  
  def record_event(document)
    @event = Event.new
    @event.animal_id = document.animal_id
    @event.update_attributes(:organization_id => document.animal.organization_id,
      :event_type => "Animal updated", 
      :event_message => "#{document.document_file_name} was uploaded to #{document.animal.name}.",
      :record_uuid => document.animal.uuid
      )
  end
  
  
end
