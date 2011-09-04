class CreateVolunteerContacts < ActiveRecord::Migration
  def self.up
    create_table :volunteer_contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :uuid
      t.string :address
      t.string :phone
      t.string :email
      t.datetime :application_date
      t.references :organization

      t.timestamps
    end
  end

  def self.down
    drop_table :volunteer_contacts
  end
end
