class AddIndexToNote < ActiveRecord::Migration
  def change
    add_index :notes, :uuid
    add_index :notes, :animal_id
    add_index :notes, :user_id
  end
end
