class RemoveImageVolunteer < ActiveRecord::Migration
  def self.up
    remove_column :volunteer_contacts, :image
    remove_column :volunteer_contacts, :image_file_name
    remove_column :volunteer_contacts, :image_content_type
    remove_column :volunteer_contacts, :image_file_size
    remove_column :volunteer_contacts, :image_updated_at
  end

  def self.down
  end
end
