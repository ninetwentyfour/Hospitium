class AddOrganizationToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :organization_id,    :uuid
    add_index :documents, :organization_id
  end
end
