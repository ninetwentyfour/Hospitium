class CreateRelinquishAnimals < ActiveRecord::Migration
  def self.up
    create_table :relinquish_animals do |t|
      t.references :animal
      t.references :relinquishment_contact

      t.timestamps
    end
  end

  def self.down
  end
end
