class CreateAdoptAPetAccount < ActiveRecord::Migration
  def self.up
    create_table "adopt_a_pet_accounts", do |t|
      t.integer "user_id"
      t.integer "organization_id"
      t.boolean "active", :default => false
      t.text "user_name"
      t.text "password"

      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
  end
end
