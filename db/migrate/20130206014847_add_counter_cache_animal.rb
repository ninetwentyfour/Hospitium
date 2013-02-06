class AddCounterCacheAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :impressions_count, :integer, :default => 0
  end
end
