class CreateAnimalEvents < ActiveRecord::Migration
  def change
    create_table :animal_events do |t|
      t.references :animal
      t.string :event_type
      t.text :event_message
      t.integer :related_model_id
      t.string :related_model_name

      t.timestamps
    end
    add_index :animal_events, :animal_id
  end
end
