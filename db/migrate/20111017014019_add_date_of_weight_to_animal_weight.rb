class AddDateOfWeightToAnimalWeight < ActiveRecord::Migration
  def self.up
    add_column :animal_weights, :date_of_weight, :datetime
  end

  def self.down
  end
end
