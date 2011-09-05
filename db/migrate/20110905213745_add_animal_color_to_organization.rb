class AddAnimalColorToOrganization < ActiveRecord::Migration
  def self.up
    change_table :animal_colors do |t|
      t.integer :organization_id
    end
  end

  def self.down
  end
end
