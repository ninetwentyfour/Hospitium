class CreateAnimalWeights < ActiveRecord::Migration
  def self.up
    create_table :animal_weights do |t|
      t.references :animal
      t.string :uuid
      t.integer :weight

      t.timestamps
    end
  end

  def self.down
    drop_table :animal_weights
  end
end
