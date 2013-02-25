class DocumentObserver < ActiveRecord::Observer
  
  def after_create(document)
    record_event(document) if document.documentable_type == "Animal"
  end
  
  def record_event(document)
    event_hash = { :type => "Animal updated", 
                   :message => "#{document.document_file_name} was uploaded to #{document.documentable.name}.", 
                   :organization => document.documentable.organization_id,
                   :uuid => document.documentable.uuid, 
                   :animal => document.documentable.id
                 }
    Event.record_event(event_hash)
  end
  
  
end
