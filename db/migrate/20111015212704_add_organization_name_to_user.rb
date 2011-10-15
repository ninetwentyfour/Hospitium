class AddOrganizationNameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :organization_name, :string
  end

  def self.down
  end
end
