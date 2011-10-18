class AddBiterToAnimal < ActiveRecord::Migration
  def self.up
    change_table :animals do |t|
      t.integer :biter_id
    end
    remove_column :animals, :biter
  end

  def self.down
  end
end
