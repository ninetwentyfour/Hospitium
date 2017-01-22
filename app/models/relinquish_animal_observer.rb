class RelinquishAnimalObserver < ActiveRecord::Observer
  observe :relinquish_animal

  # def after_create(relinquish_animal)
  #     record_event(relinquish_animal)
  # end

  # def before_destroy(relinquish_animal)
  #   record_return_event(relinquish_animal)
  # end

  # def record_event(relinquish_animal)
  #   event_hash = { :type => "Animal Relinquished",
  #                  :message => "#{relinquish_animal.name} was relinquished by #{relinquish_animal.first_name} #{relinquish_animal.last_name}",
  #                  :organization => relinquish_animal.animal.organization_id,
  #                  :uuid => relinquish_animal.animal.uuid,
  #                  :animal => relinquish_animal.animal_id,
  #                  :related_id => relinquish_animal.relinquishment_contact_id,
  #                  :related_name => "relinquishment_contact"
  #                }
  #   Event.record_event(event_hash)
  # end

  # def record_return_event(relinquish_animal)
  #   event_hash = { :type => "Animal Returned",
  #                  :message => "#{relinquish_animal.name} was returned to #{relinquish_animal.first_name} #{relinquish_animal.last_name}",
  #                  :organization => relinquish_animal.animal.organization_id,
  #                  :uuid => relinquish_animal.animal.uuid,
  #                  :animal => relinquish_animal.animal_id,
  #                  :related_id => relinquish_animal.relinquishment_contact_id,
  #                  :related_name => "relinquishment_contact"
  #                }
  #   Event.record_event(event_hash)
  # end
end
