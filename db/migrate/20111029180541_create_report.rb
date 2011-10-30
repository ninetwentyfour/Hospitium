class CreateReport < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string :report

      t.timestamps
    end
  end

  def self.down
  end
end
