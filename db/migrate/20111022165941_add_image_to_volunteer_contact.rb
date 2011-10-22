class AddImageToVolunteerContact < ActiveRecord::Migration
  def self.up
    change_table :volunteer_contacts do |t|
      t.string :image
    end
    add_column :volunteer_contacts, :image_file_name,    :string
    add_column :volunteer_contacts, :image_content_type, :string
    add_column :volunteer_contacts, :image_file_size,    :integer
    add_column :volunteer_contacts, :image_updated_at,   :datetime
  end

  def self.down
  end
end
