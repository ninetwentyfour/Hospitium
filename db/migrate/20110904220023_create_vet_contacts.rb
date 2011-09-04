class CreateVetContacts < ActiveRecord::Migration
  def self.up
    create_table :vet_contacts do |t|
      t.string :clinic_name
      t.string :uuid
      t.string :address
      t.string :phone
      t.string :email
      t.string :website
      t.string :hours
      t.string :emergency
      t.references :organization

      t.timestamps
    end
  end

  def self.down
    drop_table :vet_contacts
  end
end
