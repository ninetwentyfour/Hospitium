class RemoveExtraFieldsFromAnimal < ActiveRecord::Migration
  def self.up
    remove_column :animals, :sex
    remove_column :animals, :color
    remove_column :animals, :age
  end

  def self.down
  end
end
