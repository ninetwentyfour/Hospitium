class AddRelinquishmentFormToOrganizations < ActiveRecord::Migration
  def self.up
    add_attachment :organizations, :relinquishment_form
  end

  def self.down
    remove_attachment :organizations, :relinquishment_form
  end
end
