class DocumentObserver < ActiveRecord::Observer
  
  def after_create(document)
      record_event(document)
  end
  
  def record_event(document)
    event_hash = { :type => "Animal updated", 
                   :message => "#{document.document_file_name} was uploaded to #{document.animal.name}.", 
                   :organization => document.animal.organization_id,
                   :uuid => document.animal.uuid, 
                   :animal => document.animal_id
                 }
    Event.record_event(event_hash)
  end
  
  
end
