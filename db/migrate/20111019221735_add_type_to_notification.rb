class AddTypeToNotification < ActiveRecord::Migration
  def self.up
    change_table :notifications do |t|
      t.string :status_type
    end
  end

  def self.down
  end
end
