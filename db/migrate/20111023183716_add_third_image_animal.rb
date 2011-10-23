class AddThirdImageAnimal < ActiveRecord::Migration
  def self.up
    change_table :animals do |t|
      t.string :third_image
    end
    add_column :animals, :third_image_file_name,    :string
    add_column :animals, :third_image_content_type, :string
    add_column :animals, :third_image_file_size,    :integer
    add_column :animals, :third_image_updated_at,   :datetime
  end

  def self.down
  end
end
