class AddVolunteerFormToOrganizations < ActiveRecord::Migration
  def self.up
    add_attachment :organizations, :volunteer_form
  end

  def self.down
    remove_attachment :organizations, :volunteer_form
  end
end
