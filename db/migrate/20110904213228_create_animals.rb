class CreateAnimals < ActiveRecord::Migration
  def self.up
    create_table :animals do |t|
      t.string :name
      t.string :uuid
      t.string :previous_name
      t.references :species
      t.string :sex
      t.string :spay_neuter
      t.string :color
      t.integer :age
      t.string :biter
      t.text :special_needs
      t.text :diet
      t.datetime :date_of_intake
      t.datetime :date_of_well_check
      t.references :shelter
      t.datetime :deceased
      t.text :deceased_reason
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :animals
  end
end
