class AddRecordUuidToEvent < ActiveRecord::Migration
  def change
    add_column :events, :record_uuid,    :string
    add_index :events, :record_uuid
  end
end
