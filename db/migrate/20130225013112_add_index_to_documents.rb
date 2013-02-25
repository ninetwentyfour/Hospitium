class AddIndexToDocuments < ActiveRecord::Migration
  def change
    add_index :documents, [:documentable_id, :documentable_type]
  end
end
