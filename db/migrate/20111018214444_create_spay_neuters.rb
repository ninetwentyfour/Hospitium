class CreateSpayNeuters < ActiveRecord::Migration
  def self.up
    create_table :spay_neuters do |t|
      t.string :spay

      t.timestamps
    end
  end

  def self.down
    drop_table :spay_neuters
  end
end
