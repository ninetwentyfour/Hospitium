class AddCreatedAtToMissingModels < ActiveRecord::Migration
  def self.up
    change_table :twitter_accounts do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
  end
end
