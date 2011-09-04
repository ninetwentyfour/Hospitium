class AddOrganizationToModels < ActiveRecord::Migration
  def self.up
    change_table :animals do |t|
      t.integer :organization_id
    end
    change_table :shelters do |t|
      t.integer :organization_id
    end
    change_table :species do |t|
      t.integer :organization_id
    end
  end

  def self.down
  end
end
