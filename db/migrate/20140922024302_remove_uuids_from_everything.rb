class RemoveUuidsFromEverything < ActiveRecord::Migration
  def change
    remove_column :animals, :uuid
    remove_column :adoption_contacts, :uuid
    remove_column :animal_colors, :uuid
    remove_column :animal_weights, :uuid
    remove_column :documents, :uuid
    remove_column :foster_contacts, :uuid
    remove_column :notes, :uuid
    remove_column :organizations, :uuid
    remove_column :relinquishment_contacts, :uuid
    remove_column :shelters, :uuid
    remove_column :shots, :uuid
    remove_column :species, :uuid
    remove_column :vet_contacts, :uuid
    remove_column :volunteer_contacts, :uuid
  end
end
