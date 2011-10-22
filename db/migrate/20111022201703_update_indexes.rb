class UpdateIndexes < ActiveRecord::Migration
  def self.up
    add_index :statuses, :organization_id
    add_index :animals, :species_id
    add_index :animals, :shelter_id
    add_index :animals, :animal_color_id
    add_index :animals, :animal_sex_id
    add_index :animals, :spay_neuter_id
    add_index :animals, :biter_id
    add_index :animals, :status_id
    add_index :animals, :uuid
    add_index :organizations, :uuid
    add_index :facebook_accounts, :user_id
    add_index :twitter_accounts, :user_id
    add_index :wordpress_accounts, :user_id
    add_index :roles, :name
    add_index :permissions, :user_id
    add_index :permissions, :role_id
    add_index :adopt_animals, :animal_id
    add_index :adopt_animals, :adoption_contact_id
    add_index :relinquish_animals, :animal_id
    add_index :relinquish_animals, :relinquishment_contact_id
  end

  def self.down
  end
end
