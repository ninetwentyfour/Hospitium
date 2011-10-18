class CreateAnimalSexes < ActiveRecord::Migration
  def self.up
    create_table :animal_sexes do |t|
      t.string :sex

      t.timestamps
    end
  end

  def self.down
    drop_table :animal_sexes
  end
end
