class CreateAdoptionContacts < ActiveRecord::Migration
  def self.up
    create_table :adoption_contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :uuid
      t.string :address
      t.string :phone
      t.string :email
      t.references :animal
      t.datetime :adopted_date

      t.timestamps
    end
  end

  def self.down
    drop_table :adoption_contacts
  end
end
