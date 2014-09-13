class CreateFosterContacts < ActiveRecord::Migration
  def change
    create_table :foster_contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :uuid
      t.string :address
      t.string :phone
      t.string :email
      t.references :organization

      t.timestamps
    end
  end
end
