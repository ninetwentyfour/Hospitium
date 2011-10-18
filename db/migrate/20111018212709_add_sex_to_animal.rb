class AddSexToAnimal < ActiveRecord::Migration
  def self.up
    change_table :animals do |t|
      t.integer :animal_sex_id
    end
  end

  def self.down
  end
end
