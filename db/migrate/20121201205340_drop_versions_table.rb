class DropVersionsTable < ActiveRecord::Migration
  def up
    drop_table :versions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
