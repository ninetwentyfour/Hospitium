class AddTwitterAccounts < ActiveRecord::Migration
  def self.up
    create_table "twitter_accounts", :force => true do |t|
      t.integer "user_id"
      t.boolean "active", :default => false
      t.text "stream_url"
      t.string "oauth_token"
      t.string "oauth_token_secret"
      t.string "oauth_token_verifier"
      t.text "oauth_authorize_url"
    end
  end

  def self.down
  end
end
