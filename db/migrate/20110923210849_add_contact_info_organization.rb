class AddContactInfoOrganization < ActiveRecord::Migration
  def self.up
    add_column :organizations, :phone_number, :string
    add_column :organizations, :address, :string
    add_column :organizations, :city, :string
    add_column :organizations, :state, :string
    add_column :organizations, :zip_code, :string
    add_column :organizations, :email, :string
    add_column :organizations, :website, :string
  end

  def self.down
  end
end
