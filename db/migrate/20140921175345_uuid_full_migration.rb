# You must explicitly require it in your migration file
require 'webdack/uuid_migration/helpers'

class UuidFullMigration < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        # Good idea to do the following, needs superuser rights in the database
        # Alternatively the extension needs to be manually enabled in the RDBMS
        # enable_extension 'uuid-ossp'

        primary_key_to_uuid :activities
        primary_key_to_uuid :adopt_a_pet_accounts
        primary_key_to_uuid :adopt_animals
        primary_key_to_uuid :adoption_contacts
        primary_key_to_uuid :animal_colors
        # primary_key_to_uuid :animal_sexes
        primary_key_to_uuid :animal_weights
        # primary_key_to_uuid :biters
        primary_key_to_uuid :documents
        primary_key_to_uuid :email_blacklists
        primary_key_to_uuid :events
        primary_key_to_uuid :facebook_accounts
        primary_key_to_uuid :foster_animals
        primary_key_to_uuid :foster_contacts
        primary_key_to_uuid :impressions
        primary_key_to_uuid :notes
        primary_key_to_uuid :notifications
        primary_key_to_uuid :organizations
        # primary_key_to_uuid :organizations_users
        # primary_key_to_uuid :permissions
        primary_key_to_uuid :petfinder_accounts
        # primary_key_to_uuid :photos
        primary_key_to_uuid :posts
        primary_key_to_uuid :relinquish_animals
        primary_key_to_uuid :relinquishment_contacts
        primary_key_to_uuid :reports
        # primary_key_to_uuid :roles
        primary_key_to_uuid :shelters
        primary_key_to_uuid :shots
        # primary_key_to_uuid :spay_neuters
        primary_key_to_uuid :species
        primary_key_to_uuid :statuses
        primary_key_to_uuid :twitter_accounts
        primary_key_to_uuid :users
        primary_key_to_uuid :vet_contacts
        primary_key_to_uuid :volunteer_contacts
        primary_key_to_uuid :wordpress_accounts

        # primary_key_to_uuid :cities
        # primary_key_to_uuid :sections
        columns_to_uuid :activities, :trackable_id, :owner_id, :recipient_id
        columns_to_uuid :adopt_a_pet_accounts, :user_id, :organization_id
        columns_to_uuid :adopt_animals, :animal_id, :adoption_contact_id
        columns_to_uuid :adoption_contacts, :organization_id
        columns_to_uuid :animal_colors, :organization_id
        columns_to_uuid :animal_weights, :animal_id, :organization_id
        columns_to_uuid :animals, :species_id, :shelter_id, :organization_id, :animal_color_id, :status_id
        columns_to_uuid :documents, :animal_id, :documentable_id
        columns_to_uuid :events, :animal_id, :related_model_id, :organization_id
        columns_to_uuid :facebook_accounts, :user_id, :organization_id
        columns_to_uuid :foster_animals, :animal_id, :foster_contact_id
        columns_to_uuid :foster_contacts, :organization_id
        columns_to_uuid :impressions, :impressionable_id, :user_id
        columns_to_uuid :notes, :animal_id, :user_id
        # columns_to_uuid :organizations_users, :organization_id, :user_id
        columns_to_uuid :permissions, :user_id
        columns_to_uuid :petfinder_accounts, :user_id
        # columns_to_uuid :photos, :animal_id
        columns_to_uuid :relinquish_animals, :animal_id, :relinquishment_contact_id
        columns_to_uuid :relinquishment_contacts, :organization_id
        columns_to_uuid :reports, :organization_id
        columns_to_uuid :shelters, :organization_id
        columns_to_uuid :shots, :animal_id, :organization_id
        columns_to_uuid :species, :organization_id
        columns_to_uuid :statuses, :organization_id
        columns_to_uuid :twitter_accounts, :user_id, :organization_id
        columns_to_uuid :users, :organization_id
        columns_to_uuid :vet_contacts, :organization_id
        columns_to_uuid :volunteer_contacts, :organization_id
        columns_to_uuid :wordpress_accounts, :user_id, :organization_id
      end

      dir.down do
        raise ActiveRecord::IrreversibleMigration
      end
    end
  end
end