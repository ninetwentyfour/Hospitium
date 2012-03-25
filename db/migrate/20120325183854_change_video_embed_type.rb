class ChangeVideoEmbedType < ActiveRecord::Migration
  def up
    change_column :animals, :video_embed,    :text
  end

  def down
  end
end
