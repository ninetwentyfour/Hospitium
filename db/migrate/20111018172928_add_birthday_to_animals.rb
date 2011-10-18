class AddBirthdayToAnimals < ActiveRecord::Migration
  def self.up
    add_column :animals, :birthday, :datetime
  end

  def self.down
  end
end
