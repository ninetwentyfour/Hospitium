class CreateContactNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_notes, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.text :note
      t.string :user_id
      t.string :organization_id
      t.string :noteable_id
      t.string  :noteable_type
      t.timestamps
    end

    add_index :contact_notes, [:noteable_type, :noteable_id]
  end
end
