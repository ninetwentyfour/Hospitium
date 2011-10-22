class CreateAdoptAnimals < ActiveRecord::Migration
  def self.up
    create_table :adopt_animals do |t|
      t.references :animal
      t.references :adoption_contact

      t.timestamps
    end
  end

  def self.down
  end
end
