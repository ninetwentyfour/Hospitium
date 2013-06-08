class AddOrganizationToShot < ActiveRecord::Migration
  def change
    add_column :shots, :organization_id,    :integer
    add_index :shots, :organization_id
  end
end
