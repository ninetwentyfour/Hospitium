class AddMoreImageToAnimal < ActiveRecord::Migration
  def self.up
    add_column :animals, :image_file_name,    :string
    add_column :animals, :image_content_type, :string
    add_column :animals, :image_file_size,    :integer
    add_column :animals, :image_updated_at,   :datetime
  end

  def self.down
  end
end
