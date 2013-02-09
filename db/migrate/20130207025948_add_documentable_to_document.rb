class AddDocumentableToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :documentable_id, :integer
    add_column :documents, :documentable_type, :string
  end
end
