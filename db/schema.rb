# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140913171707) do

  create_table "adopt_a_pet_accounts", force: true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.boolean  "active",          default: false
    t.text     "user_name"
    t.text     "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adopt_a_pet_accounts", ["organization_id"], name: "index_adopt_a_pet_accounts_on_organization_id", using: :btree
  add_index "adopt_a_pet_accounts", ["user_id"], name: "index_adopt_a_pet_accounts_on_user_id", using: :btree

  create_table "adopt_animals", force: true do |t|
    t.integer  "animal_id"
    t.integer  "adoption_contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adopt_animals", ["adoption_contact_id"], name: "index_adopt_animals_on_adoption_contact_id", using: :btree
  add_index "adopt_animals", ["animal_id"], name: "index_adopt_animals_on_animal_id", using: :btree

  create_table "adoption_contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "uuid"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.datetime "adopted_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "adoption_contacts", ["organization_id"], name: "index_adoption_contacts_on_organization_id", using: :btree

  create_table "animal_colors", force: true do |t|
    t.string   "color"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "animal_colors", ["organization_id"], name: "index_animal_colors_on_organization_id", using: :btree

  create_table "animal_sexes", force: true do |t|
    t.string   "sex"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animal_weights", force: true do |t|
    t.integer  "animal_id"
    t.string   "uuid"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.datetime "date_of_weight"
  end

  add_index "animal_weights", ["animal_id"], name: "index_animal_weights_on_animal_id", using: :btree
  add_index "animal_weights", ["organization_id"], name: "index_animal_weights_on_organization_id", using: :btree

  create_table "animals", force: true do |t|
    t.string   "name"
    t.string   "uuid"
    t.string   "previous_name"
    t.integer  "species_id"
    t.text     "special_needs"
    t.text     "diet"
    t.datetime "date_of_intake"
    t.datetime "date_of_well_check"
    t.integer  "shelter_id"
    t.datetime "deceased"
    t.text     "deceased_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.datetime "adopted_date"
    t.integer  "animal_color_id"
    t.string   "image"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "public",                    default: 0
    t.datetime "birthday"
    t.integer  "animal_sex_id"
    t.integer  "spay_neuter_id"
    t.integer  "biter_id"
    t.integer  "status_id"
    t.string   "second_image"
    t.string   "second_image_file_name"
    t.string   "second_image_content_type"
    t.integer  "second_image_file_size"
    t.datetime "second_image_updated_at"
    t.string   "third_image"
    t.string   "third_image_file_name"
    t.string   "third_image_content_type"
    t.integer  "third_image_file_size"
    t.datetime "third_image_updated_at"
    t.string   "fourth_image"
    t.string   "fourth_image_file_name"
    t.string   "fourth_image_content_type"
    t.integer  "fourth_image_file_size"
    t.datetime "fourth_image_updated_at"
    t.text     "video_embed"
    t.string   "microchip"
    t.integer  "impressions_count",         default: 0
  end

  add_index "animals", ["animal_color_id"], name: "index_animals_on_animal_color_id", using: :btree
  add_index "animals", ["animal_sex_id"], name: "index_animals_on_animal_sex_id", using: :btree
  add_index "animals", ["biter_id"], name: "index_animals_on_biter_id", using: :btree
  add_index "animals", ["organization_id"], name: "index_animals_on_organization_id", using: :btree
  add_index "animals", ["public"], name: "index_animals_on_public", using: :btree
  add_index "animals", ["shelter_id"], name: "index_animals_on_shelter_id", using: :btree
  add_index "animals", ["spay_neuter_id"], name: "index_animals_on_spay_neuter_id", using: :btree
  add_index "animals", ["species_id"], name: "index_animals_on_species_id", using: :btree
  add_index "animals", ["status_id"], name: "index_animals_on_status_id", using: :btree
  add_index "animals", ["uuid"], name: "index_animals_on_uuid", using: :btree

  create_table "biters", force: true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.integer  "animal_id"
    t.string   "uuid"
    t.string   "document"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.integer  "volunteer_contact_id"
  end

  add_index "documents", ["animal_id"], name: "index_documents_on_animal_id", using: :btree
  add_index "documents", ["documentable_id", "documentable_type"], name: "index_documents_on_documentable_id_and_documentable_type", using: :btree
  add_index "documents", ["uuid"], name: "index_documents_on_uuid", using: :btree
  add_index "documents", ["volunteer_contact_id"], name: "index_documents_on_volunteer_contact_id", using: :btree

  create_table "email_blacklists", force: true do |t|
    t.string "domain"
  end

  create_table "events", force: true do |t|
    t.integer  "animal_id"
    t.string   "event_type"
    t.text     "event_message"
    t.integer  "related_model_id"
    t.string   "related_model_name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "organization_id"
    t.string   "record_uuid"
  end

  add_index "events", ["animal_id"], name: "index_animal_events_on_animal_id", using: :btree
  add_index "events", ["event_type"], name: "index_animal_events_on_event_type", using: :btree
  add_index "events", ["organization_id"], name: "index_animal_events_on_organization_id", using: :btree
  add_index "events", ["record_uuid"], name: "index_events_on_record_uuid", using: :btree
  add_index "events", ["related_model_id"], name: "index_animal_events_on_related_model_id", using: :btree

  create_table "facebook_accounts", force: true do |t|
    t.integer  "user_id"
    t.boolean  "active",              default: false
    t.text     "stream_url"
    t.text     "access_token"
    t.text     "oauth_authorize_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "facebook_accounts", ["organization_id"], name: "index_facebook_accounts_on_organization_id", using: :btree
  add_index "facebook_accounts", ["user_id"], name: "index_facebook_accounts_on_user_id", using: :btree

  create_table "foster_animals", force: true do |t|
    t.integer  "animal_id"
    t.integer  "foster_contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foster_contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "uuid"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impressions", force: true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "notes", force: true do |t|
    t.integer  "animal_id"
    t.integer  "user_id"
    t.string   "uuid"
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notes", ["animal_id"], name: "index_notes_on_animal_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree
  add_index "notes", ["uuid"], name: "index_notes_on_uuid", using: :btree

  create_table "notifications", force: true do |t|
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status_type"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "email"
    t.string   "website"
  end

  add_index "organizations", ["uuid"], name: "index_organizations_on_uuid", using: :btree

  create_table "organizations_users", id: false, force: true do |t|
    t.integer "organization_id"
    t.integer "user_id"
  end

  add_index "organizations_users", ["organization_id"], name: "index_organizations_users_on_organization_id", using: :btree
  add_index "organizations_users", ["user_id"], name: "index_organizations_users_on_user_id", using: :btree

  create_table "permissions", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["role_id"], name: "index_permissions_on_role_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

  create_table "petfinder_accounts", force: true do |t|
    t.integer  "user_id"
    t.boolean  "active",       default: false
    t.text     "ftp_user"
    t.text     "ftp_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.integer  "animal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "photos", ["animal_id"], name: "index_photos_on_animal_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "author"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relinquish_animals", force: true do |t|
    t.integer  "animal_id"
    t.integer  "relinquishment_contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relinquish_animals", ["animal_id"], name: "index_relinquish_animals_on_animal_id", using: :btree
  add_index "relinquish_animals", ["relinquishment_contact_id"], name: "index_relinquish_animals_on_relinquishment_contact_id", using: :btree

  create_table "relinquishment_contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "uuid"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "relinquishment_contacts", ["organization_id"], name: "index_relinquishment_contacts_on_organization_id", using: :btree

  create_table "reports", force: true do |t|
    t.string   "report"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "reports", ["organization_id"], name: "index_reports_on_organization_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "shelters", force: true do |t|
    t.string   "name"
    t.string   "uuid"
    t.string   "contact_first"
    t.string   "contact_last"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "shelters", ["organization_id"], name: "index_shelters_on_organization_id", using: :btree

  create_table "shots", force: true do |t|
    t.integer  "animal_id"
    t.string   "uuid"
    t.string   "name"
    t.datetime "last_administered"
    t.datetime "expires"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "organization_id"
  end

  add_index "shots", ["animal_id"], name: "index_shots_on_animal_id", using: :btree
  add_index "shots", ["expires"], name: "index_shots_on_expires", using: :btree
  add_index "shots", ["organization_id"], name: "index_shots_on_organization_id", using: :btree
  add_index "shots", ["uuid"], name: "index_shots_on_uuid", using: :btree

  create_table "spay_neuters", force: true do |t|
    t.string   "spay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "species", force: true do |t|
    t.string   "name"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "species", ["organization_id"], name: "index_species_on_organization_id", using: :btree

  create_table "statuses", force: true do |t|
    t.string   "status"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statuses", ["organization_id"], name: "index_statuses_on_organization_id", using: :btree

  create_table "twitter_accounts", force: true do |t|
    t.integer  "user_id"
    t.boolean  "active",               default: false
    t.text     "stream_url"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
    t.string   "oauth_token_verifier"
    t.text     "oauth_authorize_url"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "twitter_accounts", ["organization_id"], name: "index_twitter_accounts_on_organization_id", using: :btree
  add_index "twitter_accounts", ["user_id"], name: "index_twitter_accounts_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                                          null: false
    t.string   "encrypted_password",     limit: 128,             null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "organization_id"
    t.string   "organization_name"
    t.integer  "owner",                              default: 0
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["organization_id"], name: "index_users_on_organization_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "vet_contacts", force: true do |t|
    t.string   "clinic_name"
    t.string   "uuid"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "hours"
    t.string   "emergency"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vet_contacts", ["organization_id"], name: "index_vet_contacts_on_organization_id", using: :btree

  create_table "volunteer_contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "uuid"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.datetime "application_date"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "volunteer_contacts", ["organization_id"], name: "index_volunteer_contacts_on_organization_id", using: :btree

  create_table "wordpress_accounts", force: true do |t|
    t.integer  "user_id"
    t.boolean  "active",          default: false
    t.text     "site_url"
    t.text     "blog_user"
    t.text     "blog_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "wordpress_accounts", ["organization_id"], name: "index_wordpress_accounts_on_organization_id", using: :btree
  add_index "wordpress_accounts", ["user_id"], name: "index_wordpress_accounts_on_user_id", using: :btree

end
