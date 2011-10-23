class AddOwnerToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :owner, :integer, :default => 0
  end

  def self.down
  end
end
