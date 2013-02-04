class CreateDocument < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :animal
      t.string :uuid
      t.string :file

      t.timestamps
    end
    add_index :documents, :animal_id
    add_index :documents, :uuid
  end
end
