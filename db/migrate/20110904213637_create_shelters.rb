class CreateShelters < ActiveRecord::Migration
  def self.up
    create_table :shelters do |t|
      t.string :name
      t.string :uuid
      t.string :contact_first
      t.string :contact_last
      t.string :address
      t.string :phone
      t.string :email
      t.string :website
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :shelters
  end
end
