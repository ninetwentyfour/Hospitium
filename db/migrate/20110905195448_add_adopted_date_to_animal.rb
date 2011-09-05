class AddAdoptedDateToAnimal < ActiveRecord::Migration
  def self.up
    change_table :animals do |t|
      t.datetime :adopted_date
    end
  end

  def self.down
  end
end
