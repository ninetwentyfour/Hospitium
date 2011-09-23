class AddPublicToAnimal < ActiveRecord::Migration
  def self.up
    add_column :animals, :public, :boolean, :default => 0
  end

  def self.down
  end
end
