class AddIndexToOrganization < ActiveRecord::Migration
  def self.up
    add_index :adoption_contacts, :organization_id
    add_index :animal_colors, :organization_id
    add_index :animal_weights, :organization_id
    add_index :animals, :organization_id
    add_index :relinquishment_contacts, :organization_id
    add_index :shelters, :organization_id
    add_index :species, :organization_id
    add_index :users, :organization_id
    add_index :vet_contacts, :organization_id
    add_index :volunteer_contacts, :organization_id
  end

  def self.down
  end
end
