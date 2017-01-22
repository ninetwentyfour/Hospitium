class AddFosteredDateToAnimals < ActiveRecord::Migration[5.0]
  def change
    add_column :animals, :fostered_date, :timestamp
  end
end
