class AddFileToDocument < ActiveRecord::Migration
  def change
    rename_column :documents, :file, :document
    add_column :documents, :document_file_name,    :string
    add_column :documents, :document_content_type, :string
    add_column :documents, :document_file_size,    :integer
    add_column :documents, :document_updated_at,   :datetime
  end
end
