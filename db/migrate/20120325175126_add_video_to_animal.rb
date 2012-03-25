class AddVideoToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :video_embed,    :string
  end
end
