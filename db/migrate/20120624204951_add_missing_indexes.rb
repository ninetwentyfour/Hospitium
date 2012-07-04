class AddMissingIndexes < ActiveRecord::Migration
  def up
    add_index :adopt_a_pet_accounts, :user_id
    add_index :adopt_a_pet_accounts, :organization_id
    add_index :animal_weights, :animal_id
    add_index :facebook_accounts, :organization_id
    add_index :organizations_users, :organization_id
    add_index :organizations_users, :user_id
    add_index :reports, :organization_id
    add_index :twitter_accounts, :organization_id
    add_index :wordpress_accounts, :organization_id
  end

  def down
  end
end
