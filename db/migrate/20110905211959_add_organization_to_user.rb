class AddOrganizationToUser < ActiveRecord::Migration
  def self.up
    create_table :organizations_users, :id => false do |t|
      t.references :organization, :user
    end
  end

  def self.down
  end
end
