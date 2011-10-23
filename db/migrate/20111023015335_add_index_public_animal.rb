class AddIndexPublicAnimal < ActiveRecord::Migration
  def self.up
    add_index :animals, :public
  end

  def self.down
  end
end
