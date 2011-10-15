class AddOrganizationToTables < ActiveRecord::Migration
  def self.up
    add_column :adoption_contacts, :organization_id, :integer
    add_column :facebook_accounts, :organization_id, :integer
    add_column :animal_weights, :organization_id, :integer
    add_column :relinquishment_contacts, :organization_id, :integer
    add_column :twitter_accounts, :organization_id, :integer
    add_column :users, :organization_id, :integer
  end

  def self.down
  end
end
