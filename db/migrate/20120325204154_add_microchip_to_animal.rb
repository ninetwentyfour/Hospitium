class AddMicrochipToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :microchip,    :string
  end
end
