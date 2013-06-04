class CreateShots < ActiveRecord::Migration
  def change
    create_table :shots do |t|
      t.references :animal
      t.string :uuid
      t.string :name
      t.timestamp :last_administered
      t.timestamp :expires

      t.timestamps
    end
    add_index :shots, :animal_id
    add_index :shots, :uuid
    add_index :shots, :expires
  end
end