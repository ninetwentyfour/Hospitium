class AddFosterFormToOrganizations < ActiveRecord::Migration
  def self.up
    add_attachment :organizations, :foster_form
  end

  def self.down
    remove_attachment :organizations, :foster_form
  end
end
