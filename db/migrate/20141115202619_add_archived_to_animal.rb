class AddArchivedToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :archived, :boolean, default: false
    add_index :animals, :archived
  end
end
