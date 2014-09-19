class AddAdoptionFormToOrganizations < ActiveRecord::Migration
  def self.up
    add_attachment :organizations, :adoption_form
  end

  def self.down
    remove_attachment :organizations, :adoption_form
  end
end
