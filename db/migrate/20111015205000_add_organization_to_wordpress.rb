class AddOrganizationToWordpress < ActiveRecord::Migration
  def self.up
    add_column :wordpress_accounts, :organization_id, :integer
  end

  def self.down
  end
end
