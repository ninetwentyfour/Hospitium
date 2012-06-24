class CreateWordpressAccount < ActiveRecord::Migration
  def self.up
    create_table "wordpress_accounts" do |t|
      t.integer "user_id"
      t.boolean "active", :default => false
      t.text "site_url"
      t.text "blog_user"
      t.text "blog_password"

      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
  end
end
