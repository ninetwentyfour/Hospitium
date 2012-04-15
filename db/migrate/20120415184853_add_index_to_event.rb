class AddIndexToEvent < ActiveRecord::Migration
  def change
     add_index :animal_events, :event_type
     add_index :animal_events, :related_model_id
  end
end
