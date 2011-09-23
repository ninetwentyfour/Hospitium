class AddPublicToAnimal < ActiveRecord::Migration
  def self.up
    add_column :animals, :public, :integer, :default => 0
  end

  def self.down
  end
end
