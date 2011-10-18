class AddStatusToAnimal < ActiveRecord::Migration
  def self.up
    change_table :animals do |t|
      t.integer :status_id
    end
    remove_column :animals, :status
  end

  def self.down
  end
end
