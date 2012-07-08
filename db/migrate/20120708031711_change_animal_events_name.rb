class ChangeAnimalEventsName < ActiveRecord::Migration
  def change
      rename_table :animal_events, :events
  end
end
