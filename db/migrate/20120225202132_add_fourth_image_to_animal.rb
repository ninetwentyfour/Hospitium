class AddFourthImageToAnimal < ActiveRecord::Migration
  def self.up
    change_table :animals do |t|
      t.string :fourth_image
    end
    add_column :animals, :fourth_image_file_name,    :string
    add_column :animals, :fourth_image_content_type, :string
    add_column :animals, :fourth_image_file_size,    :integer
    add_column :animals, :fourth_image_updated_at,   :datetime
  end

  def self.down
  end
end
