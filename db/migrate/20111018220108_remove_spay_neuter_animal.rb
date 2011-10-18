class RemoveSpayNeuterAnimal < ActiveRecord::Migration
  def self.up
    remove_column :animals, :spay_neuter
  end

  def self.down
  end
end
