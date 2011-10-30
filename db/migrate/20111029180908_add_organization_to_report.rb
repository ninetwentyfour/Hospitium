class AddOrganizationToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :organization_id, :integer
  end

  def self.down
  end
end
