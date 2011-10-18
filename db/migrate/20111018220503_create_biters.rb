class CreateBiters < ActiveRecord::Migration
  def self.up
    create_table :biters do |t|
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :biters
  end
end
