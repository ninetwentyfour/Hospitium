class CreateAnimalColors < ActiveRecord::Migration
  def self.up
    create_table :animal_colors do |t|
      t.string :color
      t.string :uuid

      t.timestamps
    end
  end

  def self.down
    drop_table :animal_colors
  end
end
