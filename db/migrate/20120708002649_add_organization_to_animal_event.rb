class AddOrganizationToAnimalEvent < ActiveRecord::Migration
  def change
    add_column :animal_events, :organization_id,    :integer
    add_index :animal_events, :organization_id
  end
end
