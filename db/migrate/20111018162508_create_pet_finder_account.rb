class CreatePetFinderAccount < ActiveRecord::Migration
  def self.up
    create_table "petfinder_accounts", do |t|
      t.integer "user_id"
      t.boolean "active", :default => false
      t.text "ftp_user"
      t.text "ftp_password"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
  end
end
