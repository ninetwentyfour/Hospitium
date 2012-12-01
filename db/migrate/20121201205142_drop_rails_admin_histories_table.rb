class DropRailsAdminHistoriesTable < ActiveRecord::Migration
  def up
    drop_table :rails_admin_histories
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
