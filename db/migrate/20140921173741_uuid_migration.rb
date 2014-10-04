# You must explicitly require it in your migration file
require 'webdack/uuid_migration/helpers'

class UuidMigration < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        # Good idea to do the following, needs superuser rights in the database
        # Alternatively the extension needs to be manually enabled in the RDBMS
        enable_extension 'uuid-ossp'

        primary_key_to_uuid :animals

        # primary_key_to_uuid :cities
        # primary_key_to_uuid :sections
        columns_to_uuid :animals
      end

      dir.down do
        raise ActiveRecord::IrreversibleMigration
      end
    end
  end
end