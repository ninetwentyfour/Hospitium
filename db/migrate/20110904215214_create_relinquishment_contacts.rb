class CreateRelinquishmentContacts < ActiveRecord::Migration
  def self.up
    create_table :relinquishment_contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :uuid
      t.string :address
      t.string :phone
      t.string :email
      t.references :animal
      t.text :reason

      t.timestamps
    end
  end

  def self.down
    drop_table :relinquishment_contacts
  end
end
