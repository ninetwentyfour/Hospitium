class AddImageToAnimal < ActiveRecord::Migration
  def self.up
    change_table :animals do |t|
      t.string :image
    end
  end

  def self.down
  end
end
