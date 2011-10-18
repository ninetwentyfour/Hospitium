class AddSpayNeuterToAnimal < ActiveRecord::Migration
  def self.up
    change_table :animals do |t|
      t.integer :spay_neuter_id
    end
  end

  def self.down
  end
end
