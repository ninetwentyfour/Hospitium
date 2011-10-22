class RemoveAnimalIdAdoptRelinquish < ActiveRecord::Migration
  def self.up
    remove_column :adoption_contacts, :animal_id
    remove_column :relinquishment_contacts, :animal_id
  end

  def self.down
  end
end
