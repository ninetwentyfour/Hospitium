class AddConfimableToUser < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.confirmable
    end
    add_index :users, :confirmation_token,   :unique => true
  end

  def self.down
  end
end
