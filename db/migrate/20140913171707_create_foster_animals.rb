class CreateFosterAnimals < ActiveRecord::Migration
  def change
    create_table :foster_animals do |t|
      t.references :animal
      t.references :foster_contact

      t.timestamps
    end
  end
end
